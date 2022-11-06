///single direction (vertical or horizontal) oriented view
BaseView {
	property enum orientation { Vertical, Horizontal };	///< orientation direction

	constructor: {
		this._sizes = []
		this._scrollDelta = 0
	}

	///@private
	function move(dx, dy) {
		var horizontal = this.orientation === this.Horizontal
		var x, y
		if (horizontal && this.contentWidth > this.width) {
			x = this.contentX + dx
			if (x < 0)
				x = 0
			else if (x > this.contentWidth - this.width)
				x = this.contentWidth - this.width
			this.contentX = x
		} else if (!horizontal && this.contentHeight > this.height) {
			y = this.contentY + dy
			if (y < 0)
				y = 0
			else if (y > this.contentHeight - this.height)
				y = this.contentHeight - this.height
			this.contentY = y
		}
	}

	function positionViewAtIndex(idx) {
		if (this.trace)
			log('positionViewAtIndex ' + idx)

		var horizontal = this.orientation === this.Horizontal
		var itemBox = this.getItemPosition(idx)
		var center = this.positionMode === this.Center

		if (horizontal) {
			this.positionViewAtItemHorizontally(itemBox, center, true)
		} else {
			this.positionViewAtItemVertically(itemBox, center, true)
		}
	}

	function positionViewAtEnd() {
		if (this.orientation === this.Horizontal)
			this.positionViewAtEndHorizontally()
		else
			this.positionViewAtEndVertically()
	}

	///@private
	onKeyPressed: {
		if (!this.handleNavigationKeys) {
			event.accepted = false;
			return false;
		}

		var horizontal = this.orientation === this.Horizontal
		if (horizontal) {
			if (key === 'Left') {
				if (this.currentIndex === 0 && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				} else if (this.currentIndex === 0 && this.keyNavigationWraps) {
					this.currentIndex = this.count - 1;
				} else {
					--this.currentIndex;
				}
				event.accepted = true;
				return true;
			} else if (key === 'Right') {
				if (this.currentIndex === this.count - 1 && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				} else if (this.currentIndex === this.count - 1 && this.keyNavigationWraps) {
					this.currentIndex = 0;
				} else {
					++this.currentIndex;
				}
				event.accepted = true;
				return true;
			}
		} else {
			if (key === 'Up') {
				if (this.currentIndex === 0 && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				} else if (this.currentIndex === 0 && this.keyNavigationWraps) {
					this.currentIndex = this.count - 1;
				} else {
					--this.currentIndex;
				}
				return true;
			} else if (key === 'Down') {
				if (this.currentIndex === this.count - 1 && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				} else if (this.currentIndex === this.count - 1 && this.keyNavigationWraps) {
					this.currentIndex = 0;
				} else {
					++this.currentIndex;
				}
				event.accepted = true;
				return true;
			}
		}
	}

	///@private
	function getItemPosition(idx) {
		var items = this._items
		var item = items[idx]
		if (!item) {
			var x = 0, y = 0, w = 0, h = 0
			for(var i = idx; i >= 0; --i) {
				if (items[i]) {
					item = items[i]
					x = item.viewX + item.x
					y = item.viewY + item.y
					w = item.width
					h = item.height
					break
				}
			}
			var missing = idx - i
			if (missing > 0) {
				x += missing * (w + this.spacing)
				y += missing * (h + this.spacing)
			}
			return [x, y, w, h]
		}
		else
			return [item.viewX + item.x, item.viewY + item.y, item.width, item.height]
	}

	///@private
	function indexAt(x, y) {
		var items = this._items
		x += this.contentX
		y += this.contentY
		if (this.orientation === ListView.Horizontal) {
			for (var i = 0; i < items.length; ++i) {
				var item = items[i]
				if (!item)
					continue
				var vx = item.viewX
				if (x >= vx && x < vx + item.width)
					return i
			}
		} else {
			for (var i = 0; i < items.length; ++i) {
				var item = items[i]
				if (!item)
					continue
				var vy = item.viewY
				if (y >= vy && y < vy + item.height)
					return i
			}
		}
		return -1
	}

	///@private
	function _layout(noPrerender) {
		var model = this._modelAttached
		if (!model) {
			this.layoutFinished()
			return
		}

		this.count = model.count

		if (!this.recursiveVisible && !this.offlineLayout) {
			this.layoutFinished()
			return
		}

		var visibilityProperty = this.visibilityProperty
		var horizontal = this.orientation === this.Horizontal

		var padding = this._padding
		var paddingLeft = padding.left || 0, paddingTop = padding.top || 0
		var items = this._items
		var sizes = this._sizes
		var n = items.length
		var w = this.width - paddingLeft - (padding.right || 0), h = this.height - paddingTop - (padding.bottom || 0)
		var created = false
		var startPos = horizontal? paddingLeft: paddingTop
		var p = startPos
		var c = horizontal? this.content.x: this.content.y
		var size = horizontal? w: h
		var maxW = 0, maxH = 0

		var currentIndex = this.currentIndex
		var discardDelegates = !noPrerender
		var prerender = noPrerender? 0: this.prerender * size
		var leftMargin = -prerender
		var rightMargin = size + prerender

		if (sizes.length > items.length) {
			///fixme: override model update api to make sizes stable
			sizes.splice(items.length, sizes.length - items.length)
		}

		if (this._scrollDelta != 0) {
			if (this.nativeScrolling) {
				if (horizontal)
					this.element.setScrollX(this.element.getScrollX() - this._scrollDelta)
				else
					this.element.setScrollY(this.element.getScrollY() - this._scrollDelta)
			}
			this._scrollDelta = 0
		}

		if (this.trace)
			log("layout " + n + " into " + w + "x" + h + " @ " + this.content.x + "," + this.content.y + ", prerender: " + prerender + ", range: " + leftMargin + ":" + rightMargin)

		var refSize
		for(var i = 0; i < n; ++i) {
			var item = items[i];
			var viewPos = p + c
			var s
			if (item) {
				s = refSize = sizes[i] = (horizontal? item.width: item.height)
			} else {
				s = sizes[i]
				if (s !== undefined) {
					if (refSize === undefined)
						refSize = s
				} else
					s = refSize
			}

			var renderable = viewPos + (s !== undefined? s: 0) >= leftMargin && viewPos < rightMargin

			var visibleInModel = true
			if (visibilityProperty) {
				visibleInModel = model.getProperty(i, visibilityProperty)
				if (!visibleInModel) {
					renderable = false
					s = sizes[i] = 0
				}
			}

			if (!item && visibleInModel && (renderable || s === undefined)) {
				item = this._createDelegate(i)
				if (item) {
					s = refSize = sizes[i] = (horizontal? item.width: item.height)
					created = true
				}
			}

			if (item) {
				var visible = visibleInModel && (viewPos + s >= 0 && viewPos < size) //checking real delegate visibility, without prerender margin

				if (item.x + item.width > maxW)
					maxW = item.width + item.x
				if (item.y + item.height > maxH)
					maxH = item.height + item.y

				if (horizontal)
					item.viewX = p
				else
					item.viewY = p

				if (currentIndex === i && !item.focused) {
					this.focusChild(item)
				}

				item.visibleInView = visible

				if (!renderable && discardDelegates) {
					if (items[i]) {
						if (this.trace)
							log('discarding delegate', i)
						this._discardItem(item)
						items[i] = null
						created = true
					}
				}
			} else {
				var nextP = p + s
				if (horizontal) {
					if (nextP > maxW)
						maxW = nextP
				} else {
					if (nextP > maxH)
						maxH = nextP
				}
			}

			p += s + this.spacing
      p += (model._rows[i].subgroup ? 50 : 0)
      if (i + 1 < items.length) {
        p += (model._rows[i + 1].subgroup ? 50 : 0)
      }
		}
		if (p > startPos)
			p -= this.spacing;

		if (this.trace)
			log('result: ' + p + ', max: ' + maxW + 'x' + maxH)
		if (horizontal) {
			this.content.width = p
			this.content.height = maxH
			this.contentWidth = p
			this.contentHeight = maxH
		} else {
			this.content.width = maxW
			this.content.height = p
			this.contentWidth = maxW
			this.contentHeight = p
		}
		if (this.positionMode == this.End && !this._skipPositioning) {
			this.positionViewAtEnd()
		}
		this.layoutFinished()
		if (created)
			this._context.scheduleComplete()
	}

	/// @private creates delegate in given item slot
	function _createDelegate(idx) {
		var model = this._modelAttached;
		var item = $core.BaseView.prototype._createDelegate.apply(this, arguments)
		if (!item)
			return item
    if (model._rows[idx].subgroup) {
      item.children[0].children[0].font.pixelSize = 16;
    }
		//connect both dimensions, because we calculate maxWidth/maxHeight in contentWidth/contentHeight
		var update = function(horizontal) {
			this._scheduleLayout()
			var viewHorizontal = this.orientation === this.Horizontal
			if (this.nativeScrolling && viewHorizontal == horizontal) {
				//if delegate updates its width and it's on the left/top of scrolling position
				//it will cause annoying jumps
				var itemPos = viewHorizontal? item.viewX: item.viewY
				var itemSize = viewHorizontal? item.width: item.height
				var scrollPos = viewHorizontal? this.element.getScrollX(): this.element.getScrollY()
				if (itemPos < scrollPos) {
					this._scrollDelta += itemSize - this._sizes[idx]
				}
			}
		}
		this.connectOnChanged(item, 'width', update.bind(this, true), true) //skip initial update
		this.connectOnChanged(item, 'height', update.bind(this, false), true) //skip initial update
		return item
	}

	///@private
	function _updateOverflow() {
		if (!this.nativeScrolling) {
			$core.Item.prototype._updateOverflow.apply(this, arguments)
			return
		}
		var horizontal = this.orientation === this.Horizontal
		var style = {}
		if (horizontal) {
			style['overflow-x'] = 'auto'
			style['overflow-y'] = 'hidden'
		} else {
			style['overflow-x'] = 'hidden'
			style['overflow-y'] = 'auto'
		}
		this.style(style)
	}

	onOrientationChanged: {
		this._updateOverflow()
		this._scheduleLayout()
		this._sizes = []
	}

	onNativeScrollingChanged: {
		this._updateOverflow()
	}

	onCompleted: {
		this._updateOverflow()
	}
}
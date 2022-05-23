<!-- eslint-disable -->
<template>
  <div
    v-show="node.visible"
    ref="node"
    class="el-tree-node"
    :class="{
      'is-expanded': expanded,
      'is-current': node.isCurrent,
      'is-hidden': !node.visible,
      'is-focusable': !node.disabled,
      'is-checked': !node.disabled && node.checked
    }"
    role="treeitem"
    tabindex="-1"
    :aria-expanded="expanded"
    :aria-disabled="node.disabled"
    :aria-checked="node.checked"
    :draggable="tree.draggable"
    @click.stop="handleClick"
    @contextmenu="$event => this.handleContextMenu($event)"
    @dragstart.stop="handleDragStart"
    @dragover.stop="handleDragOver"
    @dragend.stop="handleDragEnd"
    @drop.stop="handleDrop"
  >
    <div class="el-tree-node__content" :class="{'first-level':node.level === 1, 'is-child':!node.isLeaf}" :style="{ 'padding-left': (node.level - 1) * (tree.indent- 3) + 'px' }">
      <!-- <div class="el-tree-node__content"> -->
      <!-- <span
        aria-hidden="true"
        :style="{
          'min-width': (node.level - 1) * tree.indent + 'px'
        }"
      /> -->
      <span
        :class="[
          {
            'is-leaf': node.isLeaf,
            expanded: !node.isLeaf && expanded
          },
          'el-tree-node__expand-icon',
          'el-tree-node__expand-icon-no-transition',
          tree.iconClass ? tree.iconClass : 'el-icon-caret-right'
        ]"
        @click.stop="handleExpandIconClick"
      />
      <!-- :v-show="!node.data[props.children] || !node.data[props.children].length > 0" -->
      <el-checkbox
        v-if="showCheckbox"
        v-model="node.checked"
        :indeterminate="node.indeterminate"
        :disabled="!!node.disabled"
        @click.native.stop
        @change="handleCheckChange"
      />
      <span
        v-if="node.loading"
        class="el-tree-node__loading-icon el-icon-loading"
      />
      <node-content :node="node" />
    </div>
  </div>
</template>

<script type="text/jsx">
/* eslint-disable */
import ElCheckbox from 'infogo-ui/packages/checkbox';
import emitter from 'infogo-ui/src/mixins/emitter';
import commonMethods from './model/common-methods'

export default {
  name: 'ElTreeVirtualNode',
  componentName: 'ElTreeVirtualNode',

  components: {
    ElCheckbox,
    NodeContent: {
      props: {
        node: {
          required: true
        }
      },
      render(h) {
        const parent = this.$parent
        const tree = parent.tree
        const node = this.node
        const { data, store } = node
        return parent.renderContent ? (
          parent.renderContent.call(parent._renderProxy, h, {
            _self: tree.$vnode.context,
            node,
            data,
            store
          })
        ) : tree.$scopedSlots.default ? (
          tree.$scopedSlots.default({ node, data })
        ) : (
          <span class='el-tree-node__label'>{node.label}</span>
        )
      }
    }
  },

  mixins: [emitter, commonMethods],

  props: {
    node: {
      default() {
        return {}
      }
    },
    props: {
      type: Object,
      default() {
        return {}
      }
    },
    renderContent: Function,
    showCheckbox: {
      type: Boolean,
      default: false
    }
  },

  data() {
    return {
      tree: null,
      expanded: false,
      childNodeRendered: false,
      oldChecked: null,
      oldIndeterminate: null
    }
  },

  watch: {
    'node.indeterminate'(val) {
      this.handleSelectChange(this.node.checked, val)
    },

    'node.checked'(val) {
      this.handleSelectChange(val, this.node.indeterminate)
    },

    'node.expanded'(val) {
      this.$nextTick(() => (this.expanded = val))
      if (val) {
        this.childNodeRendered = true
      }
    }
  },

  created() {
    this.init(this.$parent.$parent)
  },
  methods: {}
}
</script>

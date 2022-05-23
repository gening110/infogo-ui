<template>
<div class="el-select-tree">
  <el-select
    ref="treeSelectRef"
    clearable
    :value="selectLabel"
    :multiple="multiple"
    :placeholder="placeholder"
    :popper-class="popperClass"
    :collapse-tags="collapseTags"
    class="tree-select-select"
    @clear="handleSelectClear"
    @visible-change="visibleChange"
  >
    <!-- @remove-tag="handleSelectRemoveTag" -->
    <div class="tree-select-search" v-if="showSearch">
      <el-input
        placeholder="请输入关键字"
        v-model="treeFilterText"
        clearable
        size="mini"
        >
      </el-input>
    </div>
    <el-option :value="selectOptionValue"
      class="tree-select-option-item"
    >
      <div class="tree-select-tree-body">
        <el-tree
          id="tree-option"
          ref="optionTreeRef"
          highlight-current
          height="100%"
          ligature
          empty-text="加载中，请稍后......"
          :show-checkbox="showCheckbox"
          :data="treeData" 
          :props="treeProps"
          :node-key="nodeKey"
          :filter-node-method="filterTreeNode"
          :default-expanded-keys="defaultExpandedKeys"
          @node-click="handleNodeClick"
          @check="handleTreeCheck">
        </el-tree>
      </div>
    </el-option>
  </el-select>
</div>
</template>
<script>
const defaultProps = {
  children: 'children', // 子级字段
  label: 'name' // 展示字段
};

export default {
  name: 'ElSelectTree',
  model: {
    prop: 'defaultValue',
    event: 'change'
  },
  props: {
    // v-model值
    defaultValue: {
      type: [String, Number, Array]
    },
    // 数据源
    treeData: {
      type: Array,
      default() {
        return [];
      }
    },
    // 替换 treeNode 中 label, children 字段为 treeData 中对应的字段
    treeProps: {
      type: Object,
      default() {
        return defaultProps;
      }
    },
    // 树结构key的取值，数据唯一， 默认为id
    nodeKey: {
      type: String, default: 'id'
    },
    // 是否显示清空功能
    clearable: {
      type: Boolean, default: false
    },
    // 是否多选
    multiple: {
      type: Boolean, default: false
    },
    // 选择框默认文字
    placeholder: {
      type: String, default: '请选择'
    },
    // 搜索框默认文字
    searchPlaceholder: {
      type: String, default: '请输入关键字'
    },
    // 是否显示搜索框
    showSearch: {
      type: Boolean, default: false
    },
    // 多选时是否将选中值按文字的形式展示
    collapseTags: {
      type: Boolean, default: true
    }
  },
  data() {
    return {
      // 下拉框选中值
      selectValue: '',
      // 下拉框选中回显值
      selectLabel: '',
      // 下拉框Option的值，设置为undefined，防止选中
      selectOptionValue: undefined,
      // 树数据搜索内容
      treeFilterText: '',
      // 默认展开
      defaultExpandedKeys: []
    };
  },
  computed: {
    // 树结构是否显示复选框（多选情况下出现）
    showCheckbox() {
      return this.multiple;
    },
    // select 下拉框自定义的类名-可自行修改
    popperClass() {
      let classNames = ['custom-tree-select-popper'];
      if (this.showSearch) {
        classNames.push('custom-tree-select-search');
      }
      return classNames.join(' ');
    },
    // 下拉框实例
    treeSelectRef() {
      return this.$refs.treeSelectRef;
    },
    // 树结构实例
    optionTreeRef() {
      return this.$refs.optionTreeRef;
    }
  },
  watch: {
    // 监听默认值，对数据赋值
    defaultValue: {
      deep: true,
      immediate: true,
      handler(newValue, oldValue) {
        const { multiple } = this;
        if (newValue) {
          if (!this.reloadTreeCheck) {this.handleSetTreeCheck(newValue);}
        } else {
          this.selectValue = multiple ? [] : '';
          this.selectLabel = multiple ? [] : '';
        }
      }
    },
    treeFilterText(value) {
      setTimeout(() => {
        this.handleInputChange(value);
      }, 300);
    }
  },
  mounted() {
    // 重新加载树结构选中 false-加载 true-不加载
    this.reloadTreeCheck = false;
  },
  methods: {
    /** 多选模式下，点击移除单个tag */
    handleSelectRemoveTag(tag) {
      this.reloadTreeCheck = false;
      const { selectValue } = this;
      if (isArray(selectValue)) {
        this.selectValue.shift();
      }
      this.$emit('removeTag', tag);
    },
    /** select框的清除按钮 */
    handleSelectClear() {
      this.reloadTreeCheck = false;
      const { multiple } = this;
      const value = multiple ? [] : '';
      this.treeFilterText = '';
      this.selectValue = [ ...value ];
      this.selectLabel = [ ...value ];
      this.$emit('change', value, null);
      this.$emit('clear');
    },
    /** 树节点 点击时 */
    handleNodeClick(node) {
      const { treeProps, multiple, nodeKey } = this;
      if (multiple) return;
      if (node.children && node.children.length > 0) return;
      this.selectValue = node[nodeKey];
      this.selectLabel = node[treeProps.label];
      this.$emit('change', this.selectValue, node);
      // 下拉框失去焦点，隐藏下拉面板
      this.treeSelectRef.blur();
      // this.treeFilterText = ''
    },
    /** 树节点 复选框选中时 */
    handleTreeCheck(node, values) {
      const { treeProps } = this;
      const { checkedKeys, checkedNodes } = values;
      this.selectValue = checkedKeys;
      const lableValues = checkedNodes.map(nodeItem => {
        return nodeItem[treeProps.label];
      });
      this.selectLabel = lableValues;
      this.$emit('change', checkedKeys, checkedNodes);
    },
    /** 设置回显数据 */
    handleSetTreeNode(value) {
      const { optionTreeRef, treeProps } = this;
      this.selectValue = value;
      if (isArray(value)) {
        // 多选
        this.selectLabel = value.map(item => {
          const treeNode = optionTreeRef.getNode(item);
          return treeNode.data[treeProps.label];
        });
      } else {
        // 单选
        const treeNode = optionTreeRef.getNode(value);
        this.selectLabel = treeNode.data[treeProps.label];
      }
    },
    /** 处理数据树结构展开，并处理选中效果 */
    handleTreeExpandKeys(value) {
      const { optionTreeRef, multiple } = this;
      if (isArray(value) && multiple) {
        optionTreeRef.setCheckedKeys(value);
        value.forEach(item => {
          const treeNode = optionTreeRef.getNode(item);
          if (treeNode && treeNode.parent) {
            this.setTreeExpandKeys(treeNode.parent);
          }
        });
      } else {
        optionTreeRef.setCurrentKey(value);
        const treeNode = optionTreeRef.getNode(value);
        if (treeNode && treeNode.parent) {
          this.setTreeExpandKeys(treeNode.parent);
        }
      }
    },
    /** 处理树结构父级展开 */
    setTreeExpandKeys(node) {
      node.expanded = true;
      if (node.parent) {
        this.setTreeExpandKeys(node.parent);
      }
    },
    /** 搜索树节点 */
    filterTreeNode(value, data, node) {
      if (!value) {
        // if (node.expanded) node.expanded = false
        return true;
      }
      const { treeProps: { label } } = this;
      return data[label].indexOf(value) !== -1;
    },
    /** 设置树结构回显选中 */
    handleSetTreeCheck(value) {
      if (!this.reloadTreeCheck && value) {
        this.$nextTick(() => {
          this.handleSetTreeNode(value);
          this.handleTreeExpandKeys(value);
          this.reloadTreeCheck = true;
        });
      }
    },
    /** 搜索框中按下回车失去焦点触发 */
    handleInputChange(value) {
      this.optionTreeRef.filter(value);
    },
    // 下拉展开事件
    visibleChange(val) {
      // this.isShow = val
      this.treeFilterText = '';
      if (val) {
        setTimeout(() => {
          this.showSelect = val;
        }, 100);
      } else {
        this.showSelect = val;
      }
    }
  }
};

/**
 * 判断数据类型是否为数组
 */
function isArray(arg) {
  if (typeof Array.isArray === 'undefined') {
    return Object.prototype.toString.call(arg) === '[object Array]';
  }
  return Array.isArray(arg);
}
</script>
// <style lang="scss">
// .custom-tree-select-search {
//   .el-select-dropdown__list {
//     padding: 0;
//   }
// }
// .custom-tree-select-popper {
//   .el-scrollbar {
//     .el-select-dropdown__wrap {
//       max-height: 365px !important;
//     }
//     .el-scrollbar__bar.is-vertical {
//       z-index: 3;
//     }
//   }
// }
// </style>
// <style lang="scss" scoped>
// .tree-select-search {
//   position: sticky;
//   top: 0;
//   z-index: 2;
//   display: block;
//   padding: 6px;
//   background: #fff;
// }
// .tree-select-option-item {
//   background: #fff;
//   overflow: scroll;
//   height: 200px;
//   overflow-x: hidden;
// }
// .el-scrollbar .el-scrollbar__view .el-select-dropdown__item{
//   height: auto;
//   min-height: 200px;
//   padding: 0;
//   overflow: hidden;
// }
// </style>
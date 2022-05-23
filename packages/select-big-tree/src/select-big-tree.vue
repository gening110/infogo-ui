<!-- 下拉树 -->
<template>
<div class="el-select-big-tree">
  <el-select
    ref="bigTreeSelectRef"
    :clearable="clearable"
    :value="selectLabel"
    :multiple="multiple"
    :placeholder="placeholder"
    :popper-class="popperClassName"
    :collapse-tags="collapseTags"
    class="tree-select-select"
    @clear="handleSelectClear"
    @visible-change="visibleChange"
  >
    <!-- @remove-tag="handleSelectRemoveTag" -->
    <div v-if="showSearch" class="tree-select-search">
      <el-input
        id="ui-treeSelect-searchInput"
        v-model="treeFilterText"
        placeholder="请输入关键字"
        clearable
        size="small"
      />
    </div>
    <el-option
      :value="selectOptionValue"
      class="tree-select-option-item"
    >
      <!-- <div v-show="showLoad" class="tree-load-wrap">
        <i class="el-icon-loading" />
        <p>加载中。。。</p>
      </div> -->
      <div v-if="showSelect" class="tree-select-tree-body" :class="openVirtual ? 'virtual-tree-com':'default-tree'">
        <div class="ve-tree" style="height:100%">
          <el-tree
            v-if="isShow"
            id="tree-option"
            ref="optionTreeRef"
            height="100%"
            :ligature="ligature"
            highlight-current
            empty-text="加载中，请稍后......"
            :show-checkbox="showCheckbox"
            :data="showTreeData"
            :props="treeProps"
            :default-expand-all="treeDefaultExpandAll2"
            :node-key="treeProps.value"
            :current-node-key="radioChecked"
            :filter-node-method="filterTreeNode"
            :default-expanded-keys="treeExpandedKeys"
            :default-checked-keys="treeCheckedKeys"
            @node-click="handleNodeClick"
            @check="handleTreeCheck"
          />
          <!-- :indent="treeIndent" -->
        </div>
      </div>
    </el-option>
  </el-select>
</div>
</template>

<script>
import cloneDeep from 'lodash/cloneDeep';
import ElTree from 'infogo-ui/packages/tree';
export default {
  name: 'ElSelectBigTree',
  componentName: 'ElSelectBigTree',
  components: {
    ElTree
  },
  model: {
    prop: 'defaultValue',
    event: 'change'
  },
  props: {
    treeData: {
    // 树状数据
      type: Array,
      default: () => []
    },
    treeProps: {
    // 树状规则
      type: Object,
      default: () => {
        return {
          value: 'id', // ID字段名
          label: 'label', // 显示名称
          children: 'children', // 子级字段名
          showValue: 'label' // 显示选择结果
        };
      }
    },
    // v-model值
    defaultValue: {
      type: [String, Number, Array],
      default: () => {
        return '' || 0 || [];
      }
    },
    // 是否显示清空功能
    clearable: {
      type: Boolean,
      default: false
    },
    // 是否多选
    multiple: {
      type: Boolean,
      default: false
    },
    // 是否显示连接线
    ligature: {
      type: Boolean, default: false
    },
    // 选择框默认文字
    placeholder: {
      type: String,
      default: '请选择'
    },
    // 搜索框默认文字
    searchPlaceholder: {
      type: String,
      default: '请输入关键字'
    },
    // 是否显示搜索框
    showSearch: {
      type: Boolean,
      default: false
    },
    // 多选时是否将选中值按文字的形式展示
    collapseTags: {
      type: Boolean,
      default: true
    },
    // 默认展开的节点的 key 的数组(array)
    defaultExpandedKeys: {
      type: Array,
      default: () => []
    },
    // 默认选中的节点key数组
    checkedKeys: {
      type: Array,
      default() {
        return [];
      }
    },
    // 是否默认展开所有节点(boolean)
    treeDefaultExpandAll: {
      type: Boolean,
      default: false
    },
    popperClass: {
      type: String,
      default: ''
    },
    // 默认选中的文字
    defaultLabel: {
      type: Array,
      default() {
        return [];
      }
    },
    // 单选默认选中的
    currentNodeKey: {
      type: [String, Number],
      default: ''
    },
    // 是否开启虚拟滚动 默认开启 0不开
    openVirtual: {
      type: [String, Number],
      default: '100%'
    }
  },
  data() {
    return {
      isShow: true,
      // 下拉框选中值
      selectValue: '',
      // 下拉框选中回显值
      selectLabel: '',
      // 下拉框Option的值，设置为undefined，防止选中
      selectOptionValue: undefined,
      // 树数据搜索内容
      treeFilterText: '',
      treeDataType: 'normal',
      treeDefaultExpandAll2: false, // 是否全部展开
      treeExpandedKeys: [], // 展开的节点
      treeCheckedKeys: [], // 选中的节点
      radioChecked: '', // 单选的节点
      lazyTreeData: [], // 保留一份的数据用于懒加载
      showTreeData: [], // 用于展示的数据
      searchTimer: null, // 防抖
      showSelect: true, // 是否显示下拉框
      num: 0,
      showLoad: false
    };
  },
  computed: {
    // 树结构是否显示复选框（多选情况下出现）
    showCheckbox() {
      return this.multiple;
    },
    // select 下拉框自定义的类名-可自行修改
    popperClassName() {
      const classNames = ['custom-tree-select-popper'];
      if (this.showSearch) {
        classNames.push('custom-tree-select-search');
      }
      if (this.popperClass) {
        classNames.push(this.popperClass);
      }
      return classNames.join(' ');
    },
    // 下拉框实例
    treeSelectRef() {
      return this.$refs.bigTreeSelectRef;
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
        // 是否多选
        const { multiple } = this;
        this.handleSetTreeCheck(newValue);
        if (newValue || newValue === 0) {
          if (multiple) {
            this.treeExpandedKeys = newValue;
            this.treeCheckedKeys = newValue;
          } else {
            this.treeExpandedKeys = [newValue];
            this.radioChecked = newValue;
          }
        } else {
          this.selectValue = multiple ? [] : '';
          this.selectLabel = multiple ? [] : '';
        }
      }
    },
    treeFilterText: {
      handler(val, old) {
        if (val && val.length > 0 && val !== old) {
          this.$refs.optionTreeRef.filter(val);
        }
        if (val.length < 1 && val !== old) {
          this.$refs.optionTreeRef.filter(val);
        }
      },
      deep: true
    },
    treeData: {
      handler(val) {
        // 复制两份使用
        this.showTreeData = cloneDeep(val);
        this.lazyTreeData = cloneDeep(val);
      },
      deep: true,
      immediate: true
    },
    // 展开的节点
    // defaultExpandedKeys: {
    //   handler(val) {
    //     if (val && isArray(val) && val.length > 0) {
    //       this.treeExpandedKeys = val;
    //     }
    //   },
    //   deep: true,
    //   immediate: true
    // },

    // 勾选的节点
    // checkedKeys: {
    //   handler(val) {
    //     // console.log(val, 'check')
    //     if (val && isArray(val) && val.length > 0) {
    //       this.treeCheckedKeys = val;
    //       if (!this.reloadTreeCheck) {
    //         // this.handleSetTreeCheck(this.checkedKeys)
    //       }
    //     }
    //   },
    //   deep: true,
    //   immediate: true
    // },
    // 勾选的节点
    // currentNodeKey: {
    //   handler(val) {
    //     if (val) {
    //       this.selectValue = val;
    //       this.radioChecked = val;
    //       if (!this.reloadTreeCheck) {
    //         this.handleSetTreeCheck(val);
    //       }
    //     }
    //   },
    //   deep: true,
    //   immediate: true
    // },
    defaultLabel: {
      handler(val) {
        // console.log(val, 'label');
        if (val && isArray(val) && val.length > 0) {
        // 先判断有默认选中的值 且是多选
          if (this.defaultValue && isArray(this.defaultValue) && this.defaultValue.length > 0 && this.multiple) {
          // 在判断有没有默认的label值
            if (this.defaultLabel && isArray(this.defaultLabel) && this.defaultLabel.length > 0) {
            //
              this.selectLabel = val;
            } else {
              this.showSelect = true;
              if (!this.reloadTreeCheck) {
                this.handleSetTreeCheck(this.defaultValue);
              }
            }
          }
        }
      },
      deep: true,
      immediate: true
    }
  },
  mounted() {
    // 重新加载树结构选中 false-加载 true-不加载
    this.reloadTreeCheck = false;
  },
  created() {
    // this.getListEqu()
  },
  methods: {
    // 多选模式下，点击移除单个tag
    handleSelectRemoveTag(tag) {
      this.reloadTreeCheck = false;
      const { selectValue } = this;
      if (isArray(selectValue)) {
        this.selectValue.shift();
        this.selectLabel.shift();
      }
      // this.$emit('removeTag', tag)
      this.$emit('change', this.selectValue);
    },
    // select框的清除按钮
    handleSelectClear() {
      this.reloadTreeCheck = false;
      const { multiple } = this;
      const value = multiple ? [] : '';
      this.treeFilterText = '';
      this.selectValue = [...value];
      this.selectLabel = [...value];
      this.treeCheckedKeys = [];
      this.radioChecked = '';
      this.$emit('change', value, null);
      this.$emit('clear');
    },
    // 树节点 点击时 常用于单选
    handleNodeClick(node) {
      const { treeProps, multiple } = this;
      if (multiple) {
        return;
      }
      // if (node.children && node.children.length > 0) {
      //   return;
      // }
      this.selectValue = node[treeProps.value];
      this.selectLabel = node[treeProps.label];
      this.radioChecked = node[treeProps.value];
      this.$emit('change', this.selectValue, node);
      // 下拉框失去焦点，隐藏下拉面板
      this.treeSelectRef.blur();
      this.treeFilterText = '';
    },
    // 树节点 复选框选中时
    handleTreeCheck(node, values) {
      const { treeProps } = this;
      const { checkedKeys, checkedNodes } = values;
      this.selectValue = checkedKeys;
      this.treeExpandedKeys = checkedKeys;
      const lableValues = checkedNodes.map(nodeItem => {
        return nodeItem[treeProps.label];
      });
      this.selectLabel = lableValues;
      this.treeCheckedKeys = checkedKeys;
      this.$emit('change', checkedKeys);
    },
    // 设置回显数据
    handleSetTreeNode(value) {
      const { optionTreeRef, treeProps } = this;
      this.selectValue = value;
      if (isArray(value)) {
        // 多选
        this.selectLabel = value.map(item => {
          const treeNode = optionTreeRef.getNode(item);
          if (treeNode) {
            return treeNode.data[treeProps.label];
          }
        });
      } else {
        // 单选
        const treeNode = optionTreeRef.getNode(value);
        if (treeNode) {
          this.selectLabel = treeNode.data[treeProps.label];
        }
      }
    },
    // 处理数据树结构展开，并处理选中效果
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
    // 处理树结构父级展开
    setTreeExpandKeys(node) {
      node.expanded = true;
      if (node.parent) {
        this.setTreeExpandKeys(node.parent);
      }
    },
    // 搜索树节点
    filterTreeNode(value, data, node) {
      if (!value) {
        // if (node.expanded) node.expanded = false
        return true;
      }
      // 搜索展示子节点
      let parentNode = node.parent;
      let labels = [node.label];
      let level = 1;
      while (level < node.level) {
        labels = [...labels, parentNode.label];
        parentNode = parentNode.parent;
        level++;
      }
      return labels.some(label => label.indexOf(value) !== -1);
    },
    // 设置树结构回显选中
    handleSetTreeCheck(value) {
      this.$nextTick(() => {
        this.handleSetTreeNode(value);
      });
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
      this.$emit('visibleChange', val);
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



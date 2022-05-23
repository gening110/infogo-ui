## Select-tree 下拉树
根据数据量的不同分为`select-tree` 和 `select-big-tree`

### select-tree

适用广泛的下拉树（数据量小的）
:::demo `v-model`的值为当前被选中的`节点`的 value 属性值
```html
<template>
  <span>多选：</span>
  
  <el-select-tree
    style="display:inline-block"
    ref="tree-select-com"
    :tree-props="treeProps"
    :tree-data="treeData"
    multiple
    show-search
    clearable
    nodeKey="code"
    v-model="multipleTreeValue"
    @change="multipleChangeFn"
    @clear="multipleClearFn"
  />
  <span>单选：</span>
  <el-select-tree
    style="display:inline-block"
    ref="tree-select-com"
    :tree-props="treeProps"
    :tree-data="treeData"
    show-search
    ligature
    clearable
    v-model="treeValue"
    @change="changeFn"
    @clear="clearFn"
  />
</template>

<script>
  export default {
  data () {
     return {
        treeData: [
          {
            id: "321C8FF6CC6046D71234877526054BCF",
            text: "10001 地方",
            name: "10001 地方",
            code: "10001",
            children: [
              {
                id: "321C8FF6CC6046D79CD8877526054BCF",
                text: "1100 北京市本级",
                name: "1100 北京市本级",
                code: "1100"
              },
              {
                id: "157EAB9EA1A34D0F824E97C2C7D9F0CA",
                text: "1101 市辖区",
                name: "1101 市辖区",
                code: "1101",
                children: [
                  {
                    id: "B08F7DB39F124ACFB2171508D8C5C0FD",
                    text: "110101 东城区",
                    name: "110101 东城区",
                    code: "110101"
                  },
                  {
                    id: "2AF3A9766AAD433A95D4EADE5FB97839",
                    text: "110102 西城区",
                    name: "110102 西城区",
                    code: "110102"
                  },
                  {
                    id: "A2058EAE12674B3D9BA3710C87DDB111",
                    text: "110105 朝阳区",
                    name: "110105 朝阳区",
                    code: "110105",
                    children: [
                      {
                        id: "A1238EAE12674B3D9BA3710C87DDB111",
                        text: "11111 哈哈区",
                        name: "11111 哈哈区",
                        code: "11111"
                      }
                    ]
                  },
                  {
                    id: "C6BC2FE9FE86493291EE59171133ABB5",
                    text: "110106 丰台区",
                    name: "110106 丰台区",
                    code: "110106"
                  },
                  {
                    id: "06E478CB634F4FC19EC0381D55751218",
                    text: "110107 石景山区",
                    name: "110107 石景山区",
                    code: "110107"
                  },
                  {
                    id: "DD0B1A29473D4053989938700B73AE26",
                    text: "110108 海淀区",
                    name: "110108 海淀区",
                    code: "110108"
                  },
                  {
                    id: "5D3FF6E7729E43F9B813EAAB80796E41",
                    text: "110109 门头沟区",
                    name: "110109 门头沟区",
                    code: "110109"
                  },
                  {
                    id: "349609893FAC47BC97509B8FC411059A",
                    text: "110111 房山区",
                    name: "110111 房山区",
                    code: "110111"
                  },
                  {
                    id: "1E5B2DC4A1E84C959BB78D6E1B49A1DF",
                    text: "110112 通州区",
                    name: "110112 通州区",
                    code: "110112"
                  },
                  {
                    id: "2C9DC40AEFF8454ABF8A2EE6AD0A2DB5",
                    text: "110113 顺义区",
                    name: "110113 顺义区",
                    code: "110113"
                  },
                  {
                    id: "5C0342E4E41841AD837E365DB79E81B7",
                    text: "110114 昌平区",
                    name: "110114 昌平区",
                    code: "110114"
                  },
                  {
                    id: "DF25016580634FD39307FC0E18E7CF4F",
                    text: "110115 大兴区",
                    name: "110115 大兴区",
                    code: "110115"
                  },
                  {
                    id: "8DC99ABF109D40ED899552A08FE07C63",
                    text: "110116 怀柔区",
                    name: "110116 怀柔区",
                    code: "110116"
                  },
                  {
                    id: "9D2DA21BD26C40CC90B8BB26E1B437AC",
                    text: "110117 平谷区",
                    name: "110117 平谷区",
                    code: "110117"
                  },
                  {
                    id: "AD5172DDD7D547F5A06F022D64EB4DF5",
                    text: "110118 密云区",
                    name: "110118 密云区",
                    code: "110118"
                  },
                  {
                    id: "78B4DA4936A44314AD801B15988707D4",
                    text: "110119 延庆区",
                    name: "110119 延庆区",
                    code: "110119"
                  }
                ]
              },
              {
                id: "E8ADAB8AFDB24F77B3FA89ED7E9A9F15",
                text: "1102 县",
                name: "1102 县",
                code: "1102"
              }
            ]
          }
      ],
      treeProps: {
        label: 'name',
        children: 'children',
        value: 'code'
      },
      multipleTreeValue: ['1102', '110119'],
      treeValue: '110118',
    }
  },
  methods: {
      multipleChangeFn(data) {
        console.log('多选选中改变', data);
      },
      multipleClearFn(data) {
        console.log('多选清除', data);
      },
      changeFn(data) {
        console.log('单选选中改变', data);
      },
      clearFn(data) {
        console.log('单选清除', data);
      },
    }
}
</script>
```
:::

### select-big-tree

适用广泛的下拉树（数据量大的）
:::demo 
```html
<template>
  <span>多选：</span>
  <el-select-big-tree
    v-model="multipleTreeValue"
    style="display:inline-block"
    ref="tree-select-com"
    :tree-props="defaultProps"
    :tree-data="treeData"
    multiple
    ligature
    show-search
    @change="changeFn"
    @clear="clearFn"
  />
  <span>单选：</span>
  <el-select-big-tree
    v-model="treeValue"
    style="display:inline-block"
    ref="tree-select-com"
    :tree-props="defaultProps"
    :tree-data="treeData"
    :default-expanded-keys="defaultExpandedKeys"
    show-search
    clearable
    @change="changeFn"
    @clear="clearFn"
  />
</template>
<script>
  export default {
  data () {
     return {
        defaultProps: {
          children: 'children',
          label: 'name',
          value: 'code'
        },
        treeProps: {
          label: 'name',
          children: 'children'
        },
        treeValue: '',
        defaultExpandedKeys: [0],
        multipleTreeValue: ['110101'],
        treeData: [
          {
            id: "321C8FF6CC6046D71234877526054BCF",
            text: "10001 地方",
            name: "10001 地方",
            code: 0,
            children: [
              {
                id: "321C8FF6CC6046D79CD8877526054BCF",
                text: "1100 北京市本级",
                name: "1100 北京市本级",
                code: "1100"
              },
              {
                id: "157EAB9EA1A34D0F824E97C2C7D9F0CA",
                text: "1101 市辖区",
                name: "1101 市辖区",
                code: "1101",
                children: [
                  {
                    id: "B08F7DB39F124ACFB2171508D8C5C0FD",
                    text: "110101 东城区",
                    name: "110101 东城区",
                    code: "110101"
                  },
                  {
                    id: "2AF3A9766AAD433A95D4EADE5FB97839",
                    text: "110102 西城区",
                    name: "110102 西城区",
                    code: "110102"
                  },
                  {
                    id: "A2058EAE12674B3D9BA3710C87DDB111",
                    text: "110105 朝阳区",
                    name: "110105 朝阳区",
                    code: "110105"
                  },
                  {
                    id: "C6BC2FE9FE86493291EE59171133ABB5",
                    text: "110106 丰台区",
                    name: "110106 丰台区",
                    code: "110106"
                  },
                  {
                    id: "06E478CB634F4FC19EC0381D55751218",
                    text: "110107 石景山区",
                    name: "110107 石景山区",
                    code: "110107"
                  },
                  {
                    id: "DD0B1A29473D4053989938700B73AE26",
                    text: "110108 海淀区",
                    name: "110108 海淀区",
                    code: "110108"
                  },
                  {
                    id: "5D3FF6E7729E43F9B813EAAB80796E41",
                    text: "110109 门头沟区",
                    name: "110109 门头沟区",
                    code: "110109"
                  },
                  {
                    id: "349609893FAC47BC97509B8FC411059A",
                    text: "110111 房山区",
                    name: "110111 房山区",
                    code: "110111"
                  },
                  {
                    id: "1E5B2DC4A1E84C959BB78D6E1B49A1DF",
                    text: "110112 通州区",
                    name: "110112 通州区",
                    code: "110112"
                  },
                  {
                    id: "2C9DC40AEFF8454ABF8A2EE6AD0A2DB5",
                    text: "110113 顺义区",
                    name: "110113 顺义区",
                    code: "110113"
                  },
                  {
                    id: "5C0342E4E41841AD837E365DB79E81B7",
                    text: "110114 昌平区",
                    name: "110114 昌平区",
                    code: "110114"
                  },
                  {
                    id: "DF25016580634FD39307FC0E18E7CF4F",
                    text: "110115 大兴区",
                    name: "110115 大兴区",
                    code: "110115"
                  },
                  {
                    id: "8DC99ABF109D40ED899552A08FE07C63",
                    text: "110116 怀柔区",
                    name: "110116 怀柔区",
                    code: "110116"
                  },
                  {
                    id: "9D2DA21BD26C40CC90B8BB26E1B437AC",
                    text: "110117 平谷区",
                    name: "110117 平谷区",
                    code: "110117"
                  },
                  {
                    id: "AD5172DDD7D547F5A06F022D64EB4DF5",
                    text: "110118 密云区",
                    name: "110118 密云区",
                    code: "110118"
                  },
                  {
                    id: "78B4DA4936A44314AD801B15988707D4",
                    text: "110119 延庆区",
                    name: "110119 延庆区",
                    code: "110119"
                  }
                ]
              },
              {
                id: "E8ADAB8AFDB24F77B3FA89ED7E9A9F15",
                text: "1102 县",
                name: "1102 县",
                code: "1102"
              }
            ]
          }
      ]
    }
  },
  methods: {
      changeFn(data) {
        console.log(data);
      },
      clearFn(data) {
        console.log(data);
      },
    }
}
</script>
```
:::


### 公共
| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| multiple | 是否多选 | boolean | — | false |
| show-search | 是否可搜索 | boolean | — | false |
| clearable | 是否可搜索 | boolean | — | false |
| ligature | 是否显示连接线 | boolean | — | false |
| tree-data | 树的数据 | array | — | false |
| tree-props | 配置选项，具体看下表(props) | object | — | - |


### props
| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| label | 节点名字代表的字段 | string / number | — | label |
| value | 节点的唯一标识字段 | boolean / number | — | id |
| children | 节点子级 | array | — | children |


### select-tree Attributes
| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| value / v-model | 绑定值 | array / string / number (多选的时候是数组)| — | — |

### select-big-tree Attributes
| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| checked-keys | 多选选中的值 | array | — | — |
| default-label | 多选输入框展示的文本 | array| — | — |
| default-expanded-keys | 展开的节点 | array| — | — |
| current-node-key | 单选选中的值 | string / number| — | — |


### event
| 事件名称 | 说明 | 回调参数 |
|---------|---------|---------|
| change | 选中值发生变化时触发 | 目前的选中值 |
| visibleChange | 下拉框出现/隐藏时触发 | 出现则为 true，隐藏则为 false |
| clear | 可清空的模式下用户点击清空按钮时触发 | — |

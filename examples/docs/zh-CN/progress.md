## Progress 进度条

用于展示操作进度，告知用户当前状态和预期。

### 线形进度条

:::demo Progress 组件设置`percentage`属性即可，表示进度条对应的百分比，**必填**，必须在 0-100。通过 `format` 属性来指定进度条文字内容。

```html
<el-progress :percentage="50"></el-progress>
<el-progress :percentage="100" :format="format"></el-progress>
<el-progress :percentage="100" status="success"></el-progress>
<el-progress :percentage="100" status="warning"></el-progress>
<el-progress :percentage="50" status="exception"></el-progress>

<script>
  export default {
    methods: {
      format(percentage) {
        return percentage === 100 ? '满' : `${percentage}%`;
        // {
        //   '0%': '#108ee9',
        //   '100%': '#87d068'
        // }
      }
    }
  };
</script>
```
:::

### 百分比内显

百分比不占用额外控件，适用于文件上传等场景。

:::demo Progress 组件可通过 `stroke-width` 属性更改进度条的高度，并可通过 `text-inside` 属性来将进度条描述置于进度条内部。

```html
<el-progress :text-inside="true" :stroke-width="26" :percentage="70"></el-progress>
<el-progress :text-inside="true" :stroke-width="24" :percentage="100" status="success"></el-progress>
<el-progress :text-inside="true" :stroke-width="22" :percentage="80" status="warning"></el-progress>
<el-progress :text-inside="true" :stroke-width="20" :percentage="50" status="exception"></el-progress>
```
:::

### 自定义颜色

可以通过 `color` 设置进度条的颜色，`color` 可以接受颜色字符串，函数和数组。

:::demo

```html
<el-progress :percentage="percentage" :color="customColor"></el-progress>

<el-progress :percentage="percentage" :color="customColorMethod"></el-progress>

<el-progress :percentage="percentage" :color="customColors"></el-progress>
<div>
  <el-button-group>
    <el-button icon="el-icon-minus" @click="decrease"></el-button>
    <el-button icon="el-icon-plus" @click="increase"></el-button>
  </el-button-group>
</div>

<script>
  export default {
    data() {
      return {
        percentage: 20,
        customColor: '#536CE6',
        customColors: [
          {color: '#f56c6c', percentage: 20},
          {color: '#e6a23c', percentage: 40},
          {color: '#5cb87a', percentage: 60},
          {color: '#1989fa', percentage: 80},
          {color: '#6f7ad3', percentage: 100}
        ]
      };
    },
    methods: {
      customColorMethod(percentage) {
        if (percentage < 30) {
          return '#909399';
        } else if (percentage < 70) {
          return '#e6a23c';
        } else {
          return '#67c23a';
        }
      },
      increase() {
        this.percentage += 10;
        if (this.percentage > 100) {
          this.percentage = 100;
        }
      },
      decrease() {
        this.percentage -= 10;
        if (this.percentage < 0) {
          this.percentage = 0;
        }
      }
    }
  }
</script>
```
:::

### 渐变色

自定义进度条渐变色
linear-gradient 的封装。推荐只传两种颜色。`strokeColor`

:::demo `type='line' `参数为`{ from: string; to: string; direction: string }`或者`{ '0%': string; '100%': string}`; `type='circle'` 参数为`{ '0%': string; '100%': string}` 

```html
<el-progress :percentage="99" :strokeColor="{'0%': '#108ee9','100%': '#87d068'}"></el-progress>
<el-progress :percentage="99" :strokeColor="{ from: 'pink', to: '#87d068'}"></el-progress>
<el-progress type="circle" :percentage="99" :strokeColor="{'0%': '#108ee9','100%': '#87d068'}"></el-progress>
<el-progress type="circle" :percentage="99" :strokeColor="{'0%': 'pink','100%': '#87d068'}"></el-progress>


```
:::

### 分段进度条


:::demo Progress 组件可通过 `successPercent` 属性设置已成功的进度，并可通过 `successPercentColor` 属性设置已成功进度的颜色。

```html
<el-progress :percentage="60" :successPercent="30" color="#29CC65" successPercentColor="#536ce6"></el-progress>
<el-progress type="circle" :percentage="80" :successPercent="60" color="#29CC65" successPercentColor="#536ce6"></el-progress>
```
:::

### 环形进度条

Progress 组件可通过 `type` 属性来指定使用环形进度条，在环形进度条中，还可以通过 `width` 属性来设置其大小。

:::demo

```html
<el-progress type="circle" :percentage="0"></el-progress>
<el-progress type="circle" :percentage="25"></el-progress>
<el-progress type="circle" :percentage="100" status="success"></el-progress>
<el-progress type="circle" :percentage="70" status="warning"></el-progress>
<el-progress type="circle" :percentage="50" status="exception"></el-progress>
```
:::

### 仪表盘形进度条

:::demo 通过 `type` 属性来指定使用仪表盘形进度条。

```html

<el-progress type="dashboard" :percentage="percentage" :color="colors"></el-progress>
<el-progress type="dashboard" :successPercent="successPercent" :percentage="percentage" :color="colors" successPercentColor="red"></el-progress>
<div>
  <el-button-group>
    <el-button icon="el-icon-minus" @click="decrease"></el-button>
    <el-button icon="el-icon-plus" @click="increase"></el-button>
  </el-button-group>
</div>

<script>
  export default {
    data() {
      return {
        percentage: 10,
        successPercent: 0,
        colors: [
          {color: '#f56c6c', percentage: 20},
          {color: '#e6a23c', percentage: 40},
          {color: '#5cb87a', percentage: 60},
          {color: '#1989fa', percentage: 80},
          {color: '#6f7ad3', percentage: 100}
        ]
      };
    },
    methods: {
      increase() {
        this.percentage += 10;
        this.successPercent += 10;
        if (this.percentage > 100) {
          this.percentage = 100;
        }
        if (this.successPercent > 90) {
          this.successPercent = 90;
        }
        if (this.percentage < 20) {
          this.successPercent = 0;
        }
      },
      decrease() {
        this.percentage -= 10;
        this.successPercent -= 10;
        if (this.percentage < 0) {
          this.percentage = 0;
        }
        if (this.percentage < 20) {
          this.successPercent = 0;
        }
      }
    }
  }
</script>
```
:::

### Attributes
| 参数          | 说明            | 类型            | 可选值                 | 默认值   |
|-------------  |---------------- |---------------- |---------------------- |-------- |
| **percentage** | **百分比（必填）**   | number         |     0-100          |     0    |
| type          | 进度条类型           | string         | line/circle/dashboard | line |
| stroke-width  | 进度条的宽度，单位 px | number          | — | 6 |
| text-inside  | 进度条显示文字内置在进度条内（只在 type=line 时可用） | boolean | — | false |
| status  | 进度条当前状态 | string | success/exception/warning | — |
| color  | 进度条背景色（会覆盖 status 状态颜色） | string/function/array | — | '' |
| strokeColor  | 进度条背景色为渐变 | object | — | {} |
| successPercent  | 分段进度条进度 | number | 0-100  | 0 |
| successPercentColor  | 分段进度条背景色 | string/function/array | — | '#29CC88' |
| width  | 环形进度条画布宽度（只在 type 为 circle 或 dashboard 时可用） | number |  | 126 |
| show-text  | 是否显示进度条文字内容 | boolean | — | true |
| stroke-linecap  | circle/dashboard 类型路径两端的形状 | string | butt/round/square | round |
| format  | 指定进度条文字内容 | function(percentage) | — | — |
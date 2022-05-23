## Icon 图标

提供了一套常用的图标集合。

### 使用方法

也引入了iconFont
直接通过设置类名为 `el-icon-iconName` 来使用即可。例如：

:::demo
```html
<i class="el-icon-edit"></i>
<i class="el-icon-share"></i>
<i class="el-icon-delete"></i>
<el-button type="primary" icon="el-icon-search">搜索</el-button>

<i class="iconfont icon-xitongshezhi"></i>
<i class="iconfont icon-shouye"></i>
<i class="iconfont icon-gaojisousuo"></i>
<i class="icon-rate-face-off"></i>
<i class="icon-rate-face-1"></i>
<i class="icon-rate-face-2"></i>
<i class="icon-rate-face-3"></i>

```
:::

### 图标集合

<ul class="icon-list">
  <li v-for="name in $icon" :key="name">
    <span>
      <i :class="'el-icon-' + name"></i>
      <span class="icon-name">{{'el-icon-' + name}}</span>
    </span>
  </li>
</ul>

### 图标集合2  iconfont 图标库 当前只引入一些常用的
<ul class="icon-list">
  <li v-for="name in $iconfont" :key="name">
    <span>
      <i class="iconfont" :class="'icon-' + name"></i>
      <span class="icon-name">iconfont {{'icon-' + name}}</span>
    </span>
  </li>
</ul>


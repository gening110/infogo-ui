<script>
  import bus from '../../bus';
  import { tintColor } from '../../color.js';
  import { ACTION_USER_CONFIG_UPDATE } from '../../components/theme/constant.js';
  const varMap = {
    'primary': '$--color-primary',
    'success': '$--color-success',
    'warning': '$--color-warning',
    'danger': '$--color-danger',
    'brightYellow': '$--color-brightYellow',
    'grassGreen': '$--color-grassGreen',
    'LightBlue': '$--color-LightBlue',
    'brightRed': '$--color-brightRed',
    'orange': '$--color-orange',
    'purple': '$--color-purple',
    'tableHeader': '$--color-tableHeader',
    'white': '$--color-white',
    'black': '$--color-black',
    'textPrimary': '$--color-text-primary',
    'textRegular': '$--color-text-regular',
    'textSecondary': '$--color-text-secondary',
    'textPlaceholder': '$--color-text-placeholder',
    'borderBase': '$--divider-color-base',
    'borderLight': '$--border-color-base',
    'borderLighter': '$--background-color-base',
    'borderExtraLight': '$--border-color-light'
  };
  const original = {
    primary: '#536CE6',
    success: '#29CC65',
    warning: '#FFBF00',
    danger: '#FF4D4D',
    brightYellow: '#FADB14',
    grassGreen: '#90CC76',
    LightBlue: '#73A0FA',
    brightRed: '#EE6666',
    orange: '#F98E58',
    purple: '#854CD4',
    tableHeader: '#A6A8B3',
    white: '#FFFFFF',
    black: '#000000',
    textPrimary: '#3C404D',
    textRegular: '#686E84',
    textSecondary: '#B3B6C1',
    textPlaceholder: '#B3B6C1',
    borderBase: '#EDEDF1',
    borderLight: '#E2E2E6',
    borderLighter: '#F6F6F8',
    borderExtraLight: '#D9DAE0'
  }
  export default {
    created() {
      bus.$on(ACTION_USER_CONFIG_UPDATE, this.setGlobal);
    },
    mounted() {
      this.setGlobal();
    },
    methods: {
      tintColor(color, tint) {
        return tintColor(color, tint);
      },
      setGlobal() {
        if (window.userThemeConfig) {
          this.global = window.userThemeConfig.global;
        }
      }
    },
    data() {
      return {
        global: {},
        primary: '',
        success: '',
        warning: '',
        danger: '',
        info: '',
        white: '',
        black: '',
        textPrimary: '',
        textRegular: '',
        textSecondary: '',
        textPlaceholder: '',
        borderBase: '',
        borderLight: '',
        borderLighter: '',
        borderExtraLight: ''
      }
    },
    watch: {
      global: {
        immediate: true,
        handler(value) {
          Object.keys(original).forEach((o) => {
            if (value[varMap[o]]) {
              this[o] = value[varMap[o]]
            } else {
              this[o] = original[o]
            }
          });
        }
      }
    },
  }
</script>

## Color 色彩

为了避免视觉传达差异，使用一套特定的调色板来规定颜色，为你所搭建的产品提供一致的外观视觉感受。

### 主色

盈高主要品牌颜色是鲜艳、友好的紫色。

<el-row :gutter="12">
  <el-col :span="10" :xs="{span: 12}">
    <div class="demo-color-box" :style="{ background: primary }">Brand Color
      <div class="value">#536ce6</div>
      <div class="bg-color-sub" :style="{ background: tintColor(primary, 0.9) }">
        <div
          class="bg-blue-sub-item"
          v-for="(item, key) in Array(8)"
          :key="key"
          :style="{ background: tintColor(primary, (key + 1) / 10) }"
        ></div>
      </div>
    </div>
  </el-col>
</el-row>

### 辅助色

除了主色外的场景色，需要在不同的场景中使用（例如危险色表示危险的操作）。

<el-row :gutter="12">
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: success }"
    >Success<div class="value">#29CC65</div>
      <div 
        class="bg-color-sub"
      >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(success, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: danger }"
    >Danger<div class="value">#FF4D4D</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(danger, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: warning }"
    >Warning<div class="value">#FFBF00</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(warning, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: brightYellow }"
    >Bright yellow<div class="value">#FADB14</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(brightYellow, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: grassGreen }"
    >Grass green<div class="value">#90CC76</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(grassGreen, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: LightBlue }"
    >Light blue<div class="value">#73A0FA</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(LightBlue, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: brightRed }"
    >Bright red<div class="value">#EE6666</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(brightRed, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: orange }"
    >orange<div class="value">#F98E58</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(orange, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="8" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: purple }"
    >purple<div class="value">#854CD4</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(purple, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
  <el-col :span="6" :xs="{span: 12}">
    <div class="demo-color-box"
    :style="{ background: tableHeader }"
    >Table header<div class="value">#A6A8B3</div>
      <div 
          class="bg-color-sub"
        >
        <div 
          class="bg-success-sub-item" 
          v-for="(item, key) in Array(2)"
          :key="key"
          :style="{ background: tintColor(tableHeader, (key + 8) / 10) }"
            >
        </div>
      </div>
    </div>
  </el-col>
</el-row>

### 中性色

中性色用于文本、背景和边框颜色。通过运用不同的中性色，来表现层次结构。

<el-row :gutter="12">
  <el-col :span="6" :xs="{span: 12}">
    <div class="demo-color-box-group">
      <div class="demo-color-box demo-color-box-other"
      :style="{ background: textPrimary }"
      >主要文字<div class="value">{{textPrimary}}</div></div>
      <div class="demo-color-box demo-color-box-other"
      :style="{ background: textRegular }"
      >
      常规文字<div class="value">{{textRegular}}</div></div>
      <div class="demo-color-box demo-color-box-other"
      :style="{ background: textSecondary }"
      >次要文字<div class="value">{{textSecondary}}</div></div>
      <div class="demo-color-box demo-color-box-other"
      :style="{ background: textPlaceholder }"
      >占位文字<div class="value">{{textPlaceholder}}</div></div>
    </div>
  </el-col>
  <el-col :span="6" :xs="{span: 12}">
    <div class="demo-color-box-group">
      <div class="demo-color-box demo-color-box-other demo-color-box-lite"
      :style="{ background: borderBase }"
      >分割线<div class="value">{{borderBase}}</div></div>
      <div class="demo-color-box demo-color-box-other demo-color-box-lite"
      :style="{ background: borderLight }"
      >输入框<div class="value">{{borderLight}}</div></div>
      <div class="demo-color-box demo-color-box-other demo-color-box-lite"
      :style="{ background: borderLighter }"
      >鼠标移入<div class="value">{{borderLighter}}</div></div>
      <div class="demo-color-box demo-color-box-other demo-color-box-lite"
      :style="{ background: borderExtraLight }"
      >禁用边框<div class="value">{{borderExtraLight}}</div></div>
    </div>
  </el-col>
  <el-col :span="6" :xs="{span: 12}">
    <div class="demo-color-box-group">
      <div 
      class="demo-color-box demo-color-box-other"
      :style="{ background: black }"
      >基础黑色<div class="value">{{black}}</div></div>
      <div
      class="demo-color-box demo-color-box-other"
      :style="{ background: white, color: '#303133', border: '1px solid #eee' }"
      >基础白色<div class="value">{{white}}</div></div>
      <div class="demo-color-box demo-color-box-other bg-transparent">透明<div class="value">Transparent</div>
      </div>
    </div>
  </el-col>
</el-row>

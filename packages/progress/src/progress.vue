<template>
  <div
    class="el-progress"
    :class="[
      'el-progress--' + type,
      status ? 'is-' + status : '',
      {
        'el-progress--without-text': !showText,
        'el-progress--text-inside': textInside,
      }
    ]"
    role="progressbar"
    :aria-valuenow="percentage"
    aria-valuemin="0"
    aria-valuemax="100"
  >
    <div class="el-progress-bar" v-if="type === 'line'">
      <div class="el-progress-bar__outer" :style="{height: strokeWidth + 'px'}">
        <div class="el-progress-bar__inner" :style="barStyle">
          <div class="el-progress-bar__innerText" v-if="showText && textInside">{{content}}</div>
        </div>
        <div v-if="this.successPercent !== undefined" class="el-successPercent-bg" :style="successPercentStyle()" />
      </div>
    </div>
    <div class="el-progress-circle" :style="{height: width + 'px', width: width + 'px'}" v-else>
      <svg viewBox="0 0 100 100">
        <defs v-if="Object.keys(gradient).length">
            <linearGradient
              :id="`el-progress-gradient-${this.gradientId}`"
              x1="100%"
              y1="0%"
              x2="0%"
              y2="0%"
            >
            <stop v-for="(key, index) in Object.keys(gradient)
                .sort((a, b) => stripPercentToNumber(a) - stripPercentToNumber(b))" :key="index" :offset="key" :stop-color="gradient[key]" />
            </linearGradient>
          </defs>
        <path
          class="el-progress-circle__track"
          :d="trackPath"
          stroke="#e5e9f2"
          :stroke-width="relativeStrokeWidth"
          fill="none"
          :style="trailPathStyle"></path>
        <path
          class="el-progress-circle__path"
          :d="trackPath"
          :stroke="Object.keys(gradient).length ? `url(#el-progress-gradient-${this.gradientId})` : stroke"
          fill="none"
          :stroke-linecap="strokeLinecap"
          :stroke-width="percentage ? relativeStrokeWidth : 0"
          :style="circlePathStyle"></path>
          <path
          v-if="successPercent"
          class="el-progress-circle__path"
          :d="trackPath"
          :stroke="successPercentStroke"
          fill="none"
          :stroke-linecap="strokeLinecap"
          :stroke-width="percentage ? relativeStrokeWidth : 0"
          :style="successPercentPathStyle"></path>
      </svg>
    </div>
    <div
      class="el-progress__text"
      v-if="showText && !textInside"
      :style="{fontSize: progressTextSize + 'px'}"
    >
      <template v-if="!status">{{content}}</template>
      <i v-else :class="iconClass"></i>
    </div>
  </div>
</template>
<script>
  let gradientSeed = 0;
  export default {
    name: 'ElProgress',
    props: {
      type: {
        type: String,
        default: 'line',
        validator: val => ['line', 'circle', 'dashboard'].indexOf(val) > -1
      },
      percentage: {
        type: Number,
        default: 0,
        required: true,
        validator: val => val >= 0 && val <= 100
      },
      successPercent: {
        type: Number,
        default: 0
      },
      successPercentColor: {
        type: [String, Array, Function],
        default: '#29CC88'
      },
      status: {
        type: String,
        validator: val => ['success', 'exception', 'warning'].indexOf(val) > -1
      },
      strokeWidth: {
        type: Number,
        default: 6
      },
      strokeLinecap: {
        type: String,
        default: 'round'
      },
      textInside: {
        type: Boolean,
        default: false
      },
      width: {
        type: Number,
        default: 126
      },
      showText: {
        type: Boolean,
        default: true
      },
      color: {
        type: [String, Array, Function],
        default: ''
      },
      strokeColor: {
        type: Object,
        default: () => {
          return {};
        }
      },
      format: Function
    },
    data() {
      return {
        gradientId: 0
      };
    },
    computed: {
      gradient() {
        const strokeColorList = this.toArray(this.strokeColor);
        var object = strokeColorList.find(
          color => Object.prototype.toString.call(color) === '[object Object]'
        );
        return object;
      },
      barStyle() {
        const style = {};
        style.width = this.percentage + '%';
        style.backgroundColor = this.getCurrentColor(this.percentage);
        if (Object.keys(this.strokeColor).length) {
          style.backgroundImage = this.handleGradient(this.strokeColor);
        }
        return style;
      },
      relativeStrokeWidth() {
        return (this.strokeWidth / this.width * 100).toFixed(1);
      },
      radius() {
        if (this.type === 'circle' || this.type === 'dashboard') {
          return parseInt(50 - parseFloat(this.relativeStrokeWidth) / 2, 10);
        } else {
          return 0;
        }
      },
      trackPath() {
        const radius = this.radius;
        const isDashboard = this.type === 'dashboard';
        return `
          M 50 50
          m 0 ${isDashboard ? '' : '-'}${radius}
          a ${radius} ${radius} 0 1 1 0 ${isDashboard ? '-' : ''}${radius * 2}
          a ${radius} ${radius} 0 1 1 0 ${isDashboard ? '' : '-'}${radius * 2}
          `;
      },
      perimeter() {
        return 2 * Math.PI * this.radius;
      },
      rate() {
        return this.type === 'dashboard' ? 0.75 : 1;
      },
      strokeDashoffset() {
        const offset = -1 * this.perimeter * (1 - this.rate) / 2;
        return `${offset}px`;
      },
      trailPathStyle() {
        return {
          strokeDasharray: `${(this.perimeter * this.rate)}px, ${this.perimeter}px`,
          strokeDashoffset: this.strokeDashoffset
        };
      },
      circlePathStyle() {
        return {
          strokeDasharray: `${this.perimeter * this.rate * (this.percentage / 100) }px, ${this.perimeter}px`,
          strokeDashoffset: this.strokeDashoffset,
          transition: 'stroke-dasharray 0.6s ease 0s, stroke 0.6s ease'
        };
      },
      successPercentPathStyle() {
        return {
          strokeDasharray: `${this.perimeter * this.rate * (this.successPercent / 100) }px, ${this.perimeter}px`,
          strokeDashoffset: this.strokeDashoffset,
          transition: 'stroke-dasharray 0.6s ease 0s, stroke 0.6s ease'
        };
      },
      stroke() {
        let ret;
        if (this.color) {
          ret = this.getCurrentColor(this.percentage);
        } else {
          switch (this.status) {
            case 'success':
              ret = '#29CC88';
              break;
            case 'exception':
              ret = '#E65353';
              break;
            case 'warning':
              ret = '#FFBF00';
              break;
            default:
              ret = '#536CE6';
          }
        }
        return ret;
      },
      successPercentStroke() {
        let ret;
        if (this.successPercentColor) {
          ret = this.getCurrentSuccessPercentColor(this.successPercent);
        } else {
          switch (this.status) {
            case 'success':
              ret = '#29CC88';
              break;
            case 'exception':
              ret = '#E65353';
              break;
            case 'warning':
              ret = '#FFBF00';
              break;
            default:
              ret = '#536CE6';
          }
        }
        return ret;
      },
      iconClass() {
        if (this.status === 'warning') {
          return 'el-icon-warning';
        }
        if (this.type === 'line') {
          return this.status === 'success' ? 'el-icon-circle-check' : 'el-icon-circle-close';
        } else {
          return this.status === 'success' ? 'el-icon-check' : 'el-icon-close';
        }
      },
      progressTextSize() {
        return this.type === 'line'
          ? 12 + this.strokeWidth * 0.4
          : this.width * 0.111111 + 2 ;
      },
      content() {
        if (typeof this.format === 'function') {
          return this.format(this.percentage) || '';
        } else {
          return `${this.percentage}%`;
        }
      }
    },
    created() {
      this.gradientId = gradientSeed;
      gradientSeed += 1;
    },
    methods: {
      toArray(symArray) {
        return Array.isArray(symArray) ? symArray : [symArray];
      },
      stripPercentToNumber(percent) {
        return +percent.replace('%', '');
      },
      handleGradient(strokeColor) {
        const { from = '#1890ff', to = '#1890ff', direction = 'to right', ...rest } = strokeColor;
        if (Object.keys(rest).length !== 0) {
          const sortedGradients = this.sortGradient(rest);
          return `linear-gradient(${direction}, ${sortedGradients})`;
        }
        return `linear-gradient(${direction}, ${from}, ${to})`;
      },
      sortGradient(gradients) {
        let tempArr = [];
        // eslint-disable-next-line no-restricted-syntax
        for (const [key, value] of Object.entries(gradients)) {
          const formatKey = parseFloat(key.replace(/%/g, ''));
          if (isNaN(formatKey)) {
            return {};
          }
          tempArr.push({
            key: formatKey,
            value
          });
        }
        tempArr = tempArr.sort((a, b) => a.key - b.key);
        return tempArr.map(({ key, value }) => `${value} ${key}%`).join(', ');
      },
      successPercentStyle() {
        return {
          width: `${this.validProgress(this.successPercent)}%`,
          height: `${this.strokeWidth}px`,
          backgroundColor: this.successPercentStroke,
          position: 'absolute'
        };
      },
      getPercentage({ percentage, successPercent }) {
        const ptg = this.validProgress(percentage);
        if (!successPercent) return ptg;

        const successPtg = this.validProgress(successPercent);
        return [successPercent, this.validProgress(ptg - successPtg)];
      },
      validProgress(progress) {
        if (!progress || progress < 0) {
          return 0;
        }
        if (progress > 100) {
          return 100;
        }
        return progress;
      },
      getCurrentColor(percentage) {
        if (typeof this.color === 'function') {
          return this.color(percentage);
        } else if (typeof this.color === 'string') {
          return this.color;
        } else {
          return this.getLevelColor(percentage);
        }
      },
      getCurrentSuccessPercentColor(percentage) {
        if (typeof this.successPercentColor === 'function') {
          return this.successPercentColor(percentage);
        } else if (typeof this.successPercentColor === 'string') {
          return this.successPercentColor;
        } else {
          return this.getLevelColor(percentage);
        }
      },
      getLevelColor(percentage) {
        const colorArray = this.getColorArray().sort((a, b) => a.percentage - b.percentage);

        for (let i = 0; i < colorArray.length; i++) {
          if (colorArray[i].percentage > percentage) {
            return colorArray[i].color;
          }
        }
        return colorArray[colorArray.length - 1].color;
      },
      getColorArray() {
        const color = this.color;
        const span = 100 / color.length;
        return color.map((seriesColor, index) => {
          if (typeof seriesColor === 'string') {
            return {
              color: seriesColor,
              percentage: (index + 1) * span
            };
          }
          return seriesColor;
        });
      }
    }
  };
</script>

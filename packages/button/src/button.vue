<template>
  <el-tooltip
      effect="dark"
      :disabled="!(title && titleType === 'tooltip')"
      :content="title"
      :placement="placement">
    <button
      class="el-button"
      @click="handleClick"
      :disabled="buttonDisabled || loading"
      :autofocus="autofocus"
      :type="nativeType"
      :title="title && titleType !== 'tooltip' ? title : ''"
      :class="[
        type ? 'el-button--' + type : '',
        buttonSize ? 'el-button--' + buttonSize : '',
        {
          'is-disabled': buttonDisabled,
          'is-loading': loading,
          'is-plain': plain,
          'is-round': round,
          'is-circle': circle,
          'is-light': light,
          'is-dashed': dashed
        }
      ]"
    >
      <i class="el-icon-loading" v-if="loading"></i>
      <i :class="icon" v-if="icon && !loading"></i>
      <span v-if="$slots.default"><slot></slot></span>
    </button>
  </el-tooltip>
</template>
<script>
  export default {
    name: 'ElButton',

    inject: {
      elForm: {
        default: ''
      },
      elFormItem: {
        default: ''
      }
    },

    props: {
      type: {
        type: String,
        default: 'default'
      },
      size: String,
      icon: {
        type: String,
        default: ''
      },
      title: {
        type: String,
        default: ''
      },
      titleType: {
        type: String,
        default: ''
      },
      placement: {
        type: String,
        default: 'bottom'
      },
      nativeType: {
        type: String,
        default: 'button'
      },
      loading: Boolean,
      disabled: Boolean,
      plain: Boolean,
      autofocus: Boolean,
      round: Boolean,
      circle: Boolean,
      light: Boolean,
      dashed: Boolean
    },

    computed: {
      _elFormItemSize() {
        return (this.elFormItem || {}).elFormItemSize;
      },
      buttonSize() {
        return this.size || this._elFormItemSize || (this.$ELEMENT || {}).size;
      },
      buttonDisabled() {
        return this.$options.propsData.hasOwnProperty('disabled') ? this.disabled : (this.elForm || {}).disabled;
      }
    },

    methods: {
      handleClick(evt) {
        this.$emit('click', evt);
      }
    }
  };
</script>

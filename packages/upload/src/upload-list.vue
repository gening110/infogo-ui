<template>
  <transition-group
    tag="ul"
    :class="[
      'el-upload-list',
      'el-upload-list--' + listType,
      { 'is-disabled': disabled }
    ]"
    name="el-list"
  >
    <li
      v-for="file in files"
      :class="['el-upload-list__item', 'is-' + file.status, focusing ? 'focusing' : '']"
      :key="file.uid"
      tabindex="0"
      @keydown.delete="!disabled && $emit('remove', file)"
      @focus="focusing = true"
      @blur="focusing = false"
      @click="focusing = false"
    >
      <slot :file="file">
        <img
          class="el-upload-list__item-thumbnail"
          v-if="file.status !== 'uploading' && ['picture-card', 'picture'].indexOf(listType) > -1 || ['picture'].indexOf(listType) > -1"
          :src="file.url" alt=""
        >
        <a class="el-upload-list__item-name" @click="handleClick(file)">
          <i v-if="['picture-card', 'picture'].indexOf(listType) === -1" :class="file.status !== 'uploading'?'el-icon-paperclip':'el-icon-loading'"></i>{{file.name}}
        </a>
        <!-- <label class="el-upload-list__item-status-label">
          <i :class="{
            'el-icon-upload-success': true,
            'el-icon-circle-check': listType === 'text',
            'el-icon-check': ['picture-card', 'picture'].indexOf(listType) > -1
          }"></i>
        </label> -->
        <!-- v-if="!disabled" -->
        <i v-if="['picture-card', 'picture'].indexOf(listType) > -1" class="el-icon-close" @click="$emit('remove', file)"></i>
        <i v-else class="list-delete el-icon-delete" @click="$emit('remove', file)"></i>
        <!-- <i class="el-icon-close-tip" v-if="!disabled">{{ t('el.upload.deleteTip') }}</i> -->
        <!--因为close按钮只在li:focus的时候 display, li blur后就不存在了，所以键盘导航时永远无法 focus到 close按钮上-->
        <div class="progress-box">
          <p v-if="file.status === 'uploading' && listType === 'picture-card'"  class="picture-card-loading">
            <span class="el-icon-loading" />
          </p>
        <el-progress
          v-if="file.status === 'uploading'"
          :type="'line'"
          :stroke-width="listType === 'picture-card' ? 6 : 2"
          color="#29cc65"
          :show-text="false"
          :percentage="parsePercentage(file.percentage)">
        </el-progress>
        </div>
        <!-- listType === 'picture-card' ? 'circle' :  -->
        <span class="el-upload-list__item-actions" v-if="listType === 'picture-card'">
          <span
            class="el-upload-list__item-preview"
            v-if="handlePreview && listType === 'picture-card'"
            @click="handlePreview(file)"
          >
            <i class="el-icon-zoom-in"></i>
          </span>
          <span
            v-if="!disabled"
            class="el-upload-list__item-delete"
            @click="$emit('remove', file)"
          >
            <i class="el-icon-delete"></i>
          </span>
        </span>
      </slot>
    </li>
  </transition-group>
</template>
<script>
  import Locale from 'infogo-ui/src/mixins/locale';
  import ElProgress from 'infogo-ui/packages/progress';

  export default {

    name: 'ElUploadList',

    mixins: [Locale],

    data() {
      return {
        focusing: false
      };
    },
    components: { ElProgress },

    props: {
      files: {
        type: Array,
        default() {
          return [];
        }
      },
      disabled: {
        type: Boolean,
        default: false
      },
      handlePreview: Function,
      listType: String
    },
    methods: {
      parsePercentage(val) {
        console.log(val);
        return parseInt(val, 10);
      },
      handleClick(file) {
        this.handlePreview && this.handlePreview(file);
      }
    }
  };
</script>

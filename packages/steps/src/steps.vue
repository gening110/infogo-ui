<template>
  <div
    class="el-steps"
    :class="[
       !simple && 'el-steps--' + direction,
       !simple && spotted && 'el-steps--spotted',
       simple && 'el-steps--simple',
     ]">
      <slot></slot>
  </div>
</template>

<script>
import Migrating from 'infogo-ui/src/mixins/migrating';

export default {
  name: 'ElSteps',

  mixins: [Migrating],

  props: {
    space: [Number, String],
    active: Number,
    direction: {
      type: String,
      default: 'horizontal'
    },
    alignCenter: Boolean,
    simple: Boolean,
    spotted: Boolean,
    finishStatus: {
      type: String,
      default: 'success'
    },
    processStatus: {
      type: String,
      default: 'process'
    }
  },

  data() {
    return {
      steps: [],
      stepOffset: 0
    };
  },

  methods: {
    getMigratingConfig() {
      return {
        props: {
          'center': 'center is removed.'
        }
      };
    }
  },

  watch: {
    active(newVal, oldVal) {
      this.$emit('change', newVal, oldVal);
    },

    steps(steps) {
      steps.forEach((child, index) => {
        child.index = index;
      });
    }
  }
};
</script>

import ElSelectBigTree from './src/select-big-tree';

/* istanbul ignore next */
ElSelectBigTree.install = function(Vue) {
  Vue.component(ElSelectBigTree.name, ElSelectBigTree);
};

export default ElSelectBigTree;

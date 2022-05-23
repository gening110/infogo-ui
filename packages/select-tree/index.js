import ElSelectTree from './src/select-tree';

/* istanbul ignore next */
ElSelectTree.install = function(Vue) {
  Vue.component(ElSelectTree.name, ElSelectTree);
};

export default ElSelectTree;

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="./styles/font.css">
    <link rel='mask-icon' href="/examples/assets/images/element-logo-small.svg" color="#536CE6">
    <link rel="stylesheet" href="./styles/color-brewer.css">
    <title>InfoGoUi - The world's most popular Vue UI framework</title>
    <meta name="description" content="infogo，一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的桌面端组件库" />
  </head>
  <body>
    <script>
      if (!window.Promise) {
        document.write('<script src="//cdn.jsdelivr.net/npm/es6-promise@4.1.1/dist/es6-promise.min.js"><\/script><script>ES6Promise.polyfill()<\/script>')
      }
    </script>
    <div id="app"></div>
    <% if (process.env.NODE_ENV === 'production') { %>
      <script src="./js/vue.runtime.min.js"></script>
      <script src="./js/vue-router.min.js"></script>
      <script src="./js/highlight.pack.js"></script>
    <% } %>
  </body>
  <% if (process.env.NODE_ENV !== 'production') { %><script>
    var ga = function() {
      console.log(arguments)
    };
  </script><% } %>
</html>

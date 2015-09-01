//= require react/JSXTransformer
//= require react/react-with-addons
//= require lodash.min
//= require jquery-2.1.4.min

//= require_tree ./components

React.render(
  <App list={window.location.hash}/>,
  document.getElementById("container")
);

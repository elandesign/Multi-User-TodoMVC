import React from 'react/addons';
import App from './components/app.jsx';

React.render(
  <App list={window.location.hash}/>,
  document.getElementById("container")
);

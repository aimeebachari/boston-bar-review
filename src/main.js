import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';

$(function() {
  if (document.getElementById('App')){
    ReactDOM.render(
      <App />,
      document.getElementById('App')
    );
  }
});

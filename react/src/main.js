import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import BarList from './BarList';

$(function() {
  if (document.getElementById('BarList')){
  ReactDOM.render(
    <BarList />,
    document.getElementById('BarList')
  );
  }
});

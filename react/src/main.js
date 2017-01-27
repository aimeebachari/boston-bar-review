import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import ReviewList from './components/ReviewList';
import BarList from './components/BarList';

$(function() {
  if (document.getElementById('BarList')){
    ReactDOM.render(
      <BarList />,
      document.getElementById('BarList')
    );
  } else {
    if (document.getElementById('ReviewList')){
      ReactDOM.render(
        <ReviewList />,
        document.getElementById('ReviewList')
      );
    }
  }
});

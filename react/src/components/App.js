/* jshint esversion:6*/

import React, { Component } from 'react';
import Vote from './Vote';
// import data from '../constants/data'

class App extends Component {
  constructor(props){
    super(props);
    this.state = {
      reviews: [],
      body: "",
      rating: null
    }
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleEditChange = this.handleEditChange.bind(this)
    this.handleDelete = this.handleDelete.bind(this)
    this.handleUpVote = this.handleUpVote.bind(this)
    this.handleDownVote = this.handleDownVote.bind(this)
  }

  handleDownVote(reviewId){
    let fetchBody = {id: reviewId, type: "down_votes"}
    let newReviews = []
    fetch(`/api/v1/reviews/${reviewId}`,
    { method: "PATCH",
      body: JSON.stringify(fetchBody)
    }).then(function(response){
      newReviews = response.json()
      return newReviews
    }).then((response) => this.setState({reviews: response}))
  }

  handleUpVote(reviewId){
    let fetchBody = {id: reviewId, type: "up_votes"}
    let newReviews = []
    fetch(`/api/v1/reviews/${reviewId}`,
    { method: "PATCH",
      body: JSON.stringify(fetchBody)
    }).then(function(response){
      newReviews = response.json()
      return newReviews
    }).then((response) => this.setState({reviews: response}))
  }

  handleDelete(reviewId){
    let fetchBody = { id: reviewId }
    let newReviews = []
    fetch(`/api/v1/reviews/${reviewId}`,
    { method: "DELETE",
      body: JSON.stringify(fetchBody)
    }).then(function(response){
      newReviews = response.json()
      return newReviews
    }).then((response) => this.setState({reviews: response}))
  }

  handleEditChange(event){
    let newRating = event.target.value;
    let newBody = event.target.value;
    this.setState({
      rating: newRating,
      body: newBody
    })
  }

  handleSubmit(event){
    event.preventDefault()
    let fetchBody = { rating: this.state.rating, body: this.state.body }
    let newReviews = []
    fetch(`api/v1/reviews`, {
      method: "POST",
      body: JSON.stringify(fetchBody)
    }).then(function(response){
      newReviews = response.json()
      return newReviews
    }).then((response) => this.setState({
      reviews: response,
    }))
  }

  componentDidMount() {
    let url = window.location.href.split("/");
    let barId = url[url.length - 1];
    $.ajax({
      method: "GET",
      url: `${barId}/api/v1/reviews`,
    })
    .done(data => {
      this.setState({
        reviews: data
      });
    })
  }

handleDelete(reviewId){
  let fetchBody = { id: reviewId }
  let newReviews = []
  fetch(`/api/v1/reviews/${reviewId}`,
  { method: "DELETE",
    body: JSON.stringify(fetchBody)
  }).then(function(response){
    newReviews = response.json()
    return newReviews
  }).then((response) => this.setState({reviews: response}))
}

  render(){
    let reviews = this.state.reviews.map(review => {
      let handleUpVoteClick = () => {
        this.handleUpVoteClick(review.id)
      }
      let handleDownVoteClick = () => {
        this.handleDownVoteClick(review.id)
      }
      let handleSubmit = () => {
        this.handleSubmit(event)
      }
      let handleDelete = () => {
        this.handleDelete(review.id)
      }
      let handleEditChange = () => {
        this.handleEditChange(review.id)
      }
      return (
        <Vote
          handleUpVoteClick={handleUpVoteClick}
          handleDownVoteClick={handleDownVoteClick}
          handleSubmit={handleSubmit}
          handleDelete={handleDelete}
          handleEditChange={handleEditChange}
        />
      );
    });

    return(
      <div>
        {reviews}
      </div>
    )
  }
}


export default App;

import React, { Component } from 'react';

class Vote extends Component {
  constructor(props){
    super(props);
    this.state = {
      upVote: false,
      downVote: false,
      upSum: 0,
      downSum: 0

    }
    this.handleUpVoteClick = this.handleUpVoteClick.bind(this);
    this.handleDownVoteClick = this.handleDownVoteClick.bind(this);
  }

  handleDownVote(reviewId){
    let url = window.location.href.split("/");
    let barId = url[url.length - 1];
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
    let url = window.location.href.split("/");
    let barId = url[url.length - 1];
    let fetchBody = {id: reviewId, type: "up_votes"}
    let newReviews = []
    fetch(`/${barId}/api/v1/reviews/${reviewId}`,
    { method: "PATCH",
      body: JSON.stringify(fetchBody)
    }).then(function(response){
      newReviews = response.json()
      return newReviews
    }).then((response) => this.setState({reviews: response}))
  }

  handleUpVoteClick(){
    if (!this.state.upVote && !this.state.downVote) {
      let newUpSum = this.state.upSum + 1;
      this.setState({
        upVote: true,
        upSum: newUpSum
      })
    }
    else if (!this.state.upVote && this.state.downVote) {
      let newUpSum = this.state.upSum + 1;
      let newDownSum = this.state.downSum - 1;
      this.setState({
        upVote: true,
        downVote: false,
        upSum: newUpSum,
        downSum: newDownSum

      })
    }
    else if (this.state.upVote && !this.state.downVote) {
      let newUpSum = this.state.upSum - 1;
      this.setState({
        upVote: false,
        upSum: newUpSum
      })
    }
    let reviewId = parseInt($('.item-title').first().attr("id"));
    let url = window.location.href.split("/");
    let barId = url[url.length - 1];
    let fetchBody = {id: reviewId, type: "up_votes"}

    fetch(`/api/v1/bars/${barId}/reviews/${reviewId}`,
    { method: "PATCH",
      body: JSON.stringify(fetchBody),
      credentials: 'include'
    }).then(function(response){
      let newResponse = response.json()
      return newResponse;
    }).then(response => {this.setState({
      upSum: this.state.upSum +1
    })
    })

  }

  handleDownVoteClick(){
    if (!this.state.downVote && !this.state.upVote) {
      let newDownSum = this.state.downsum + 1;
      this.setState({
        downVote: true,
        sum: newDownSum
      })
    }
    else if (!this.state.downVote && this.state.upVote) {
      let newDownSum = this.state.downSum + 1;
      let newUpSum = this.state.upSum - 1;
      this.setState({
        downVote: true,
        upVote: false,
        downSum: newDownSum,
        upSum: newUpSum

      })
    }
    else if (this.state.downVote && !this.state.upVote) {
      let newDownSum = this.state.downSum - 1;
      this.setState({
        downVote: false,
        downSum: newDownSum
      });
    }
    let reviewId = parseInt($('.item-title').first().attr("id"));
    let url = window.location.href.split("/");
    let barId = url[url.length - 1];
    let fetchBody = {id: reviewId, type: "down_votes"}

    fetch(`/api/v1/bars/${barId}/reviews/${reviewId}`,
    { method: "PATCH",
      body: JSON.stringify(fetchBody),
      credentials: 'include'
    }).then(function(response){
      let newResponse = response.json()
      return newResponse;
    }).then(response => {this.setState({
      downSum: this.state.downSum +1
    })
    })
  }

  render(){
    let upSum = this.state.upSum;
    let downSum = this.state.downSum;
    let handleUpVoteClick = () => {this.handleUpVoteClick();};
    let handleDownVoteClick = () => {this.handleDownVoteClick();};
    return(
      <div>
        <button className = "upVote" onClick = {handleUpVoteClick}>Up</button>
        <button className = "downVote" onClick = {handleDownVoteClick}>Down</button>
        {upSum}
        {downSum}
      </div>
    )

  }
}

export default Vote;

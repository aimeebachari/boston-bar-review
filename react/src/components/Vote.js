import React, { Component } from 'react';

class Vote extends Component {
  constructor(props){
    super(props);
    this.state = {
      upVote: false,
      downVote: false,
      sum: 0,
    }
    this.handleUpVoteClick = this.handleUpVoteClick.bind(this);
    this.handleDownVoteClick = this.handleDownVoteClick.bind(this);
  }

  handleUpVoteClick(){
    if (!this.state.upVote && !this.state.downVote) {
      let newSum = this.state.sum + 1;
      this.setState({
        upVote: true,
        sum: newSum
      })
    }
    else if (!this.state.upVote && this.state.downVote) {
      let newSum = this.state.sum + 2;
      this.setState({
        upVote: true,
        downVote: false,
        sum: newSum
      })
    }
    else if (this.state.upVote && !this.state.downVote) {
      let newSum = this.state.sum - 1;
      this.setState({
        upVote: false,
        sum: newSum
      })
    }
  }

  handleDownVoteClick(){
    if (!this.state.downVote && !this.state.upVote) {
      let newSum = this.state.sum - 1;
      this.setState({
        downVote: true,
        sum: newSum
      })
    }
    else if (!this.state.downVote && this.state.upVote) {
      let newSum = this.state.sum - 2;
      this.setState({
        downVote: true,
        upVote: false,
        sum: newSum
      })
    }
    else if (this.state.downVote && !this.state.upVote) {
      let newSum = this.state.sum + 1;
      this.setState({
        downVote: false,
        sum: newSum
      });
    }
  }
  render(){
    let sum = this.state.sum;
    let handleUpVoteClick = () => {this.handleUpVoteClick();};
    let handleDownVoteClick = () => {this.handleDownVoteClick();};
    return(
      <div>
        <button className = "upVote" onClick = {handleUpVoteClick}>Up</button>
        <button className = "downVote" onClick = {handleDownVoteClick}>Down</button>
        {sum}
      </div>
    )

  }
}

export default Vote;

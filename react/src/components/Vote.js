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
        downSumsum: newDownSum
      });
    }
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

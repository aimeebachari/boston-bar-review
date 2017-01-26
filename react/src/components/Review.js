import React, {Component} from 'react';

class Review extends Component {
  constructor(props) {
    super(props)
    this.state = {}
  }

  render() {
    let body = null;
    let upvote = null;
    let downvote = null;
    let edit = null;
    let destroy = null;

    if (this.props.body) {
      body = <p>{this.props.body}</p>
    }

    if (this.props.currentUser) {
      upvote = <button className="upVote" onClick={this.props.handleUpvote}>Up</button>
      downvote = <button className="downVote" onClick={this.props.handleDownvote}>Down</button>
    }

    if (this.props.currentUser.id === this.props.user.id) {
      edit =<div className="button">
              <a href={`/bars/${this.props.barId}/reviews/${this.props.id}/edit`}>Edit</a>
            </div>
      destroy = <div className="button" onClick={this.props.handleDelete} id={`destroy-${this.props.id}`}>Delete</div>
    }

    let score = <p>{this.props.score}</p>

    return(
      <div>
        {this.props.rating} | {body}
        <div>
          {score}
          {upvote}
          {downvote}
          {edit}
          {destroy}
        </div>
      </div>
    )
  }
}

export default Review;

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

    if (this.props.currentUser === this.props.userId) {
      edit =<div className="button">
              <a href={`/bars/${this.props.barId}/review/${this.props.id}/edit`}>Edit</a>
            </div>
      destroy = <div className="button" onClick={this.props.handleDelete}>Delete</div>
    }

    return(
      <div>
        <p>{this.props.user.username}</p>
        {body}
        <div>
          {this.props.votes}
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

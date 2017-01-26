import React, {Component} from 'react';

class Review extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let body = null;
    let upvote = null;
    let downvote = null;
    let edit = null;
    let destroy = null;

    if (this.props.body) {
      body = <span>{this.props.body}</span>;
    }

    if (this.props.currentUser) {
      upvote = <i className="fa fa-thumbs-o-up" aria-hidden="true" onClick={this.props.handleUpvote}></i>;
      downvote = <i className="fa fa-thumbs-o-down" aria-hidden="true" onClick={this.props.handleDownvote}></i>;
    }

    if (this.props.currentUser.id === this.props.user.id) {
      edit = <a href={`/bars/${this.props.barId}/reviews/${this.props.id}/edit`}>Edit</a>;
      // destroy = <div className="button" onClick={this.props.handleDelete} id={`destroy-${this.props.id}`}>Delete</div>;
      destroy = <a href="javascript:;" onClick={this.props.handleDelete} id={`destroy-${this.props.id}`}>Delete</a>;
    }

    let score = <span>{this.props.score}</span>;

    return(
      <div>
        {this.props.rating} | {body} | Score: {score} | {upvote} | {downvote} | {edit} | {destroy}
      </div>
    );
  }
}

export default Review;

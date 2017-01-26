import React, {Component} from 'react';
import Review from './Review';

class ReviewList extends Component {
  constructor(props) {
    super(props)
    this.state = {
      currentUser: null,
      reviews: [],
      users: [],
      barId: null
    }

    this.handleVote = this.handleVote.bind(this);
    this.handleDelete = this.handleDelete.bind(this);
  }

  handleVote(type, review) {
    let data = {
      review_id: review.id,
    }
    let jsonStringData = JSON.stringify(data);
    fetch(`/api/v1/bars/${this.state.barId}/reviews/${review.id}/${type}`, {
      credentials: 'same-origin',
      method: 'post',
      headers: { 'Content-Type': 'application/json' },
      body: jsonStringData
    })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => {
        fetch(`/api/v1/bars/${this.state.barId}`, {
          credentials: 'same-origin'
        })
          .then(response => {
            if (response.ok) {
              return response;
            } else {
              let errorMessage = `${response.status}, (${response.statusText})`;
              let error = new Error(errorMessage);
              throw(error);
            }
          })
          .then(response => response.json())
          .then(body => {
            let newReviews = body.reviews;
            let newUsers = body.users;
            this.setState({
              reviews: newReviews,
              users: newUsers,
            });
          });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  handleDelete(reviewId) {
    fetch(`/api/v1/bars/${this.state.barId}/reviews/${reviewId}`, {
      method: 'delete',
      credentials: 'same-origin'
    })
    .then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status}, (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(response => {
      fetch(`/api/v1/bars/${this.state.barId}`,{
        credentials: 'same-origin'
      })
        .then(response => {
          if (response.ok) {
            return response;
          } else {
            let errorMessage = `${response.status}, (${response.statusText})`;
            let error = new Error(errorMessage);
            throw(error);
          }
        })
        .then(response => response.json())
        .then(body => {
          let newReviews = body.reviews;
          let newUsers = body.users;
          this.setState({
            reviews: newReviews,
            users: newUsers,
          });
        });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
    }

    componentDidMount() {
      let newReviewId = parseInt($('.item-title').first().attr("id"));
      let url = window.location.href.split("/");
      let newBarId = url[url.length - 1];

      fetch(`/api/v1/bars/${newBarId}`, {
        credentials: 'same-origin'
      })
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status}, (${response.statusText})`;
          let error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        let newCurrentUser = body.currentUser
        let newReviews = body.reviews
        let newUsers = body.users
        this.setState({
          currentUser: newCurrentUser,
          reviews: newReviews,
          users: newUsers,
          barId: newBarId
        })
      })
    }



    render() {
      let counter = -1
      let reviews
      if (this.state.reviews) {
        reviews = this.state.reviews.map((review) => {
          counter ++

          let handleUpvote = () => {
            return(
              this.handleVote('up_vote', review)
            )
          }

          let handleDownvote = () => {
            return(
              this.handleVote('down_vote', review)
            )
          }

          let handleDeleteReview = () => {
            return(
              this.handleDelete(review.id)
            )
          }

          let handleDelete = this.handleDelete
          return(
            <Review
              key = {review.id}
              id = {review.id}
              rating = {review.rating}
              body = {review.body}
              score = {review.score}
              user = {this.state.users[counter]}
              handleUpvote = {handleUpvote}
              handleDownvote = {handleDownvote}
              handleDelete = {handleDeleteReview}
              currentUser = {this.state.currentUser}
              barId = {this.state.barId}
            />
          )
        })
      }
      reviews = reviews.sort(function(a,b) {
        return b.key - a.key
      })
      return(
        <div>
          <h4>Reviews</h4>
          {reviews}
        </div>
      )
    }
}

export default ReviewList;

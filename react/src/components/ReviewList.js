import React, {Component} from 'react';

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
  }

  handleVote(type, review) {
    let data = {
      review_id: review.id,
    }
    let jsonStringData = JSON.stringify(data);
    fetch(`/api/v1/reviews/${review.id}/${type}`, {
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
        fetch(`/api/v1/bars/${this.state.barId}.json`)
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
    fetch(`/api/vi/reviews/${review.Id}`, {
      method: 'delete'
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
      fetch(`/api/v1/bars/${this.state.barId}.json`)
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
      let newBarId = parseInt($('.item-title').first().attr("id"));
      fetch(`/api/v1/bars/${newBarId}.json`, {
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
        this.setState( {
          currentUser: newCurrentUser,
          reviews: newReviews,
          users: newUsers,
          barId: newBarId
        })
      })
    }

    render() {
      let counter = -1
      let reviews = this.state.reviews.map((review) => {
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

        return(
          <Review
            key = {review.id}
            id = {review.id}
            rating = {review.rating}
            body = {review.body}
            votes = {review.votes}
            user = {this.state.users[counter]}
            handleUpvote = {handleUpvote}
            handleDownvote = {handleDownvote}
            handleDelete = {handleDelete}
            currentUser = {this.state.currentUser}
            barId = {this.state.itemId}
          />
        )
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

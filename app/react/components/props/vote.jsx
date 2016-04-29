import React from 'react';

export default class Vote extends React.Component {
  static get propTypes() {
    return {
      onUpvote: React.PropTypes.func.isRequired,
      upvotesCount: React.PropTypes.number.isRequired,
      isUpvotePossible: React.PropTypes.bool.isRequired,
      upVoting: React.PropTypes.bool,
      undoUpvote: React.PropTypes.func.isRequired,
    };
  }

  render() {
    const ratingButton = (
      <button className="btn btn-default rating-button" disabled>
        Rating + {this.props.upvotesCount}
      </button>
    );

    const upvoteButton = (
      <button className="btn btn-success upvote-button" onClick={this.props.onUpvote}>
        +1
      </button>
    );

    const undoUpvoteButton = (
      <button className="btn btn-danger undo-upvote-button" onClick={this.props.undoUpvote}>
        -1
      </button>
    );

    return (
      <div className="btn-group pull-right">
        { this.props.upvotesCount > 0 ? ratingButton : null }
        { this.props.isUpvotePossible ? upvoteButton : undoUpvoteButton }
      </div>
    );
  }
}

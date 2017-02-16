import React from 'react';

const Vote = ({
  onUpvote,
  upvotesCount,
  isUpvotePossible,
  isUndoUpvotePossible,
  undoUpvote,
}) => {
  const ratingButton = (
    <button
      data-test="rating"
      className="btn btn-default"
      disabled
    >
      Rating + {upvotesCount}
    </button>
  );

  const upvoteButton = (
    <button
      data-test="upvote"
      className="btn btn-success"
      onClick={onUpvote}
    >
      +1
    </button>
  );

  const undoUpvoteButton = (
    <button
      data-test="undo-upvote"
      className="btn btn-danger"
      onClick={undoUpvote}
    >
      -1
    </button>
  );

  return (
    <div className="btn-group pull-right">
      { upvotesCount > 0 && ratingButton }
      { isUpvotePossible && upvoteButton }
      { isUndoUpvotePossible && undoUpvoteButton }
    </div>
  );
};

Vote.propTypes = {
  onUpvote: React.PropTypes.func.isRequired,
  upvotesCount: React.PropTypes.number.isRequired,
  isUpvotePossible: React.PropTypes.bool.isRequired,
  isUndoUpvotePossible: React.PropTypes.bool.isRequired,
  undoUpvote: React.PropTypes.func.isRequired,
};

export default Vote;

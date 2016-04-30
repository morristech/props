import React from 'react';
import { Link } from 'react-router';

export default class Thumb extends React.Component {
  static get propTypes() {
    return {
      id: React.PropTypes.number.isRequired,
      name: React.PropTypes.string.isRequired,
      avatarUrl: React.PropTypes.string.isRequired,
    };
  }

  render() {
    const { id, avatarUrl, name } = this.props;

    return (
      <div className="col-xs-6 col-sm-3 col-md-2">
        <Link to={`/app/users/${id}`} className="thumbnail user-card">
          <img src={avatarUrl} />
          <div className="caption">
            {name}
          </div>
        </Link>
      </div>
    );
  }
}

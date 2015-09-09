import React from 'react';

export default class UserThumb extends React.Component {
  static get propTypes() {
    return {
      user: React.PropTypes.object.isRequired,
    };
  }

  render() {
    const userUrl = `#users/${this.props.user.id}`;
    return (
      <div className="col-xs-6 col-sm-3 col-md-2">
        <a className="thumbnail user-card" href={userUrl}>
          <img src={this.props.user.avatar_url} />
          <div className="caption">
            {this.props.user.name}
          </div>
        </a>
      </div>
    );
  }
}

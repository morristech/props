import React from 'react';

export default class UserThumb extends React.Component {
  static get propTypes() {
    return {
      id: React.PropTypes.number.isRequired,
      name: React.PropTypes.string.isRequried,
      avatarUrl: React.PropTypes.string.isRequired,
    };
  }

  render() {
    const userUrl = `#users/${this.props.id}`;
    return (
      <div className="col-xs-6 col-sm-3 col-md-2">
        <a className="thumbnail user-card" href={userUrl}>
          <img src={this.props.avatarUrl} />
          <div className="caption">
            {this.props.name}
          </div>
        </a>
      </div>
    );
  }
}

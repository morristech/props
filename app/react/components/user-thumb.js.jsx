import React from 'react';

class UserThumb extends React.Component {
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

UserThumb.propTypes = {
  user: React.PropTypes.object.isRequired,
};

export default UserThumb;

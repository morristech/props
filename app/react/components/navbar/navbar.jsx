import React, { PropTypes } from 'react';

import NavbarLinks from './navbar-links';
import NavbarSettings from './navbar-settings';

export default class Navbar extends React.Component {
  static get propTypes() {
    return {
      isOnAppPage: PropTypes.bool.isRequired,
      user: PropTypes.shape({
        name: PropTypes.string,
        email: PropTypes.string,
      }),
      userSignedIn: PropTypes.bool.isRequired,
    };
  }

  get links() {
    if (!this.props.userSignedIn) {
      return [];
    }

    if (this.props.isOnAppPage) {
      return [{ name: 'Props', url: '/app#props' }, { name: 'Users', url: '/users' }];
    }

    return [{ name: 'App', url: '/app' }];
  }

  get user() {
    return this.props.user || {};
  }

  render() {
    return (
      <div className="nav navbar navbar-default navbar-static-top">
        <div className="container">
          <div className="navbar-header">
            <button className="navbar-toggle"
              data-target=".navbar-collapse"
              data-toggle="collapse"
              type="button"
            >
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-logo" href="#">Props App</a>
          </div>

          <div className="collapse navbar-collapse">
            <NavbarLinks links={this.links} />
            <NavbarSettings user={this.user} userSignedIn={this.props.userSignedIn} />
          </div>
        </div>
      </div>
    );
  }
}

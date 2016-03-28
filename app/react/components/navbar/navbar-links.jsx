import React, { PropTypes } from 'react';

export default class NavbarLinks extends React.Component {
  static get propTypes() {
    return {
      links: PropTypes.arrayOf(PropTypes.shape({
        url: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
      })),
    };
  }

  renderLinks() {
    return this.props.links.map(link =>
      <li key={link.url}><a href={link.url}>{link.name}</a></li>
    );
  }

  render() {
    return (
      <ul className="nav navbar-nav">
        {this.renderLinks()}
      </ul>
    );
  }
}

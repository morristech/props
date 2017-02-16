import React, { Component, PropTypes } from 'react';
import cx from 'classnames';
import Select from 'react-select';
import 'react-select/dist/react-select.css';
import { forIn } from 'lodash';
import AvatarOption from './AvatarOption';
import styles from './style.css';

class AddProp extends Component {
  constructor(props) {
    super(props);
    this.state = {
      praisedUsers: [],
      propText: '',
    };

    this.handleSelectChange = this.handleSelectChange.bind(this);
    this.handlePropText = this.handlePropText.bind(this);
  }

  getOptions() {
    const options = [];
    const data = this.props.users;
    const isCurrentUser = id => (
      this.props.currentUser.id === id
    );

    forIn(data, (option) => {
      options.push({
        label: option.name,
        value: option.id,
        avatar: option.avatar_url,
        disabled: isCurrentUser(option.id),
      });
    });
    return options;
  }

  handleSelectChange(praisedUsers) {
    this.setState({ praisedUsers });
  }

  handlePropText(event) {
    this.setState({ propText: event.target.value });
  }

  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <div
            className={cx(
              'jumbotron',
              styles.grid,
            )}
          >
            <div className="selected-users">
              {
                this.state.praisedUsers.map(user => (
                  <img
                    key={user.value}
                    className="praised-person-avatar"
                    src={user.avatar}
                    alt="avatar"
                  />
                ))
              }
            </div>
            <form>
              <div className="form-group">
                <Select
                  multi
                  disabled={false}
                  value={this.state.praisedUsers}
                  placeholder="Whom do you want to give a prop to?"
                  options={this.getOptions()}
                  onChange={this.handleSelectChange}
                  optionComponent={AvatarOption}
                />
              </div>
              <div className="form-group">
                <textarea
                  rows="2"
                  placeholder="What do you want to thank for?"
                  className="form-control"
                  type="text"
                  value={this.state.propText}
                  onChange={this.handlePropText}
                />
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

AddProp.propTypes = {
  users: PropTypes.objectOf(PropTypes.object),
  currentUser: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    email: PropTypes.string,
    avatar_url: PropTypes.string,
  }),
};

export default AddProp;

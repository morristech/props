import React, { PropTypes } from 'react';
import Select from 'react-select';
import UserOptionComponent from './prop-user-option';
import SelectedUsersComponent from './selected-users';
import classNames from 'classnames';

export default class PropsForm extends React.Component {

  static get propTypes() {
    return {
      avatars: PropTypes.array,
      selected_users: PropTypes.array,
      users: PropTypes.array,
      selected_users_ids: PropTypes.array,
      prop_creation_errors: PropTypes.object,
      prop_creation_request: PropTypes.bool,
      thanksText: PropTypes.string,
      onPropSubmit: PropTypes.func,
      onThanksTextChange: PropTypes.func,
      onFormLoad: PropTypes.func,
      onSelectChange: PropTypes.func,
    };
  }

  constructor(props) {
    super(props);
    this.onPropSubmit = this.onPropSubmit.bind(this);
    this.renderBodyError = this.renderBodyError.bind(this);
    this.bodyErrorClass = this.bodyErrorClass.bind(this);
    this.renderSelectError = this.renderSelectError.bind(this);
    this.selectErrorClass = this.selectErrorClass.bind(this);
    this.onThanksTextChange = this.onThanksTextChange.bind(this);
  }

  componentDidMount() {
    this.props.onFormLoad();
  }

  onPropSubmit(event) {
    event.preventDefault();
    const formData = new FormData();
    formData.append('user_ids', this.props.selected_users_ids);
    formData.append('body', event.target.getElementsByTagName('textarea')[0].value);
    this.props.onPropSubmit(formData);
  }

  onThanksTextChange(event) {
    this.props.onThanksTextChange(event.target.value);
  }

  bodyErrorClass() {
    return classNames('form-group', {
      'has-error': this.props.prop_creation_errors.body,
    });
  }

  selectErrorClass() {
    return classNames('form-group', {
      'has-error': this.props.prop_creation_errors.user_ids,
    });
  }

  renderBodyError() {
    if (this.props.prop_creation_errors.body) {
      return (
        <span className="help-block error">
          {this.props.prop_creation_errors.body[0]}
        </span>
      );
    }
    return '';
  }

  renderSelectError() {
    if (this.props.prop_creation_errors.user_ids) {
      return (
        <span className="help-block error">
          {this.props.prop_creation_errors.user_ids[0]}
        </span>
      );
    }
    return '';
  }

  render() {
    const {
      prop_creation_request,
      avatars,
      thanksText,
      users,
      selected_users,
      onSelectChange,
    } = this.props;

    if (prop_creation_request) {
      return (
        <div className="loading" />
      );
    }

    return (
      <div classNameName="header-region row">
        <div className="jumbotron clearfix">
          <div className="form-region">
            <form data-type="new" onSubmit={this.onPropSubmit}>
              <div id="form-content-region">
                <div>
                  <SelectedUsersComponent avatars={avatars} />
                  <div className={ this.selectErrorClass() }>
                    <div className="users-select">
                      <Select
                        options={users}
                        multi={true}
                        optionComponent={UserOptionComponent}
                        name="user_ids"
                        placeholder="Whom do you want to give a prop to?"
                        onChange={onSelectChange}
                        value={selected_users}
                      />
                      {this.renderSelectError()}
                    </div>
                  </div>
                  <div className={this.bodyErrorClass()}>
                    <textarea
                      className="form-control"
                      id="prop_body"
                      name="body"
                      rows="2"
                      placeholder="What do you want to thank for?"
                      value={thanksText}
                      onChange={this.onThanksTextChange}
                    >
                    </textarea>
                    { this.renderBodyError() }
                  </div>
                </div>
              </div>
              <footer className="form-footer">
                <ul className="list-inline">
                  <li className="pull-right">
                    <button
                      className="form-button btn btn-primary"
                      data-form-button="primary"
                      type="submit"
                    >
                      Prop!
                    </button>
                  </li>
                </ul>
              </footer>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

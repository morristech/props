import React from 'react';
window.React = React;
import ReactDOM from 'react-dom';
window.ReactDOM = ReactDOM;

import PropsListComponent from './components/props';
import SelectedUsersComponent from './components/selected-users';
import Select from 'react-select';
import UserOptionComponent from './components/prop-user-option';
import UserThumb from './components/user/thumb';

registerComponent('PropsListComponent', PropsListComponent);
registerComponent('SelectedUsersComponent', SelectedUsersComponent);
registerComponent('Select', Select);
registerComponent('UserOptionComponent', UserOptionComponent);
registerComponent('UserThumb', UserThumb);

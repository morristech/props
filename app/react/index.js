import React from 'react';
window.React = React;

import PropsListComponent from './components/props-list';
import SelectedUsersComponent from './components/selected-users';
import Select from 'react-select';
import UserOptionComponent from './components/prop-user-option';
import UserThumb from './components/user-thumb';

registerComponent('PropsListComponent', PropsListComponent);
registerComponent('SelectedUsersComponent', SelectedUsersComponent);
registerComponent('Select', Select);
registerComponent('UserOptionComponent', UserOptionComponent);
registerComponent('UserThumb', UserThumb);

import RWR from 'react-webpack-rails';
RWR.run();

import PropsListComponent from './components/props';
import SelectedUsersComponent from './components/selected-users';
import Select from 'react-select';
import UserOptionComponent from './components/prop-user-option';
import UserThumb from './components/user/thumb';
import AnnouncementComponent from './components/announcement';

RWR.registerComponent('PropsListComponent', PropsListComponent);
RWR.registerComponent('SelectedUsersComponent', SelectedUsersComponent);
RWR.registerComponent('Select', Select);
RWR.registerComponent('UserOptionComponent', UserOptionComponent);
RWR.registerComponent('UserThumb', UserThumb);
RWR.registerComponent('AnnouncementComponent', AnnouncementComponent);

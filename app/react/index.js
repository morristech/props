import RWR from 'react-webpack-rails';
RWR.run();

import AppContainer from './components/app-container';
import PropsListComponent from './components/props';
import UserThumb from './components/user/thumb';
import AnnouncementComponent from './components/announcement';
import NavbarComponent from './components/navbar/navbar';

RWR.registerComponent('AppContainer', AppContainer);
RWR.registerComponent('PropsListComponent', PropsListComponent);
RWR.registerComponent('UserThumb', UserThumb);
RWR.registerComponent('AnnouncementComponent', AnnouncementComponent);
RWR.registerComponent('NavbarComponent', NavbarComponent);

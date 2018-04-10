/* Main JavaScript file that tracks a RootStack of pages the user
 * has visited for navigational flow. MUST BE CAREFUL TO NOT RESTACK
 * PAGES WHEN USER IS GOING IN LOOPS, aka Classes -> Map -> Group Page
 * -> Classes, as stack will keep rising if done improperly.
 *
 * TODO: -update with every new page added
 *********************************************************************/

'use strict';
import React, { Component } from 'react';
import { StackNavigator } from 'react-navigation'; 
import {
  Platform,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import Login from './Login';
import CreateUser from './CreateUser';
import AwaitingConfirmation from './AwaitingConfirmation';
import Settings from './Settings';
import GroupPage from './GroupPage';
import ClassPage from './ClassPage';
import NewGroupA from './NewGroupA';
import NewGroupB from './NewGroupB';
import NewGroupC from './NewGroupC';
import NewGroupD from './NewGroupD';

const RootStack = StackNavigator(
 {
  Login: {
    screen: Login,
  },
  CreateUser: {
    screen: CreateUser,
  },
  AwaitingConfirmation: {
    screen: AwaitingConfirmation,
  },
  Settings: {
    screen: Settings,
  },
  GroupPage: {
    screen: GroupPage,
  },
  ClassPage: {
    screen: ClassPage,
  },
    NewGroupA: {
    screen: NewGroupA,
  },
      NewGroupB: {
    screen: NewGroupB,
  },
      NewGroupC: {
    screen: NewGroupC,
  },
        NewGroupD: {
    screen: NewGroupD,
  },
 },
 {
  initialRouteName: 'Login',
 }
);

export default class App extends Component <{}> {
  render() {
    return <RootStack />;
  }
}

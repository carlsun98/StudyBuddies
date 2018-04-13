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
import MapPage from './MapPage';
import { NavigationComponent } from 'react-native-material-bottom-navigation';
import { TabNavigator } from 'react-navigation'

const ClassPageNavigator = StackNavigator(
  {
    ClassPage: {screen: ClassPage},
  },
  {
    initialRouteName: 'ClassPage',
  }
);

const MapPageNavigator = StackNavigator(
  {
    MapPage: {screen: MapPage},
  },
  {
    initialRouteName: 'MapPage',
  }
);

const GroupPageNavigator = StackNavigator(
  {
    GroupPage: {screen: GroupPage},
  },
  {
    initialRouteName: 'GroupPage',
  },
)

const SettingsNavigator = StackNavigator(
  {
    SettingsPage: {screen: Settings},
  },
  {
    initialRouteName: 'SettingsPage',
  },
);

const TabBarPage = TabNavigator(
  {
    ClassPageNavigator: {screen: ClassPageNavigator},
    MapPageNavigator: {screen: MapPageNavigator },
    GroupPageNavigator: {screen:  GroupPageNavigator},
    SettingsNavigator: { screen: SettingsNavigator }
  },
  {
    tabBarComponent: NavigationComponent,
    tabBarPosition: 'bottom',
    tabBarOptions: {
      bottomNavigationOptions: {
        labelColor: '#98d894',
        rippleColor: 'white',
        tabs: {
          ClassPageNavigator: {
            label: "Classes",
            barBackgroundColor: "#1E1E46",
            activeLabelColor: "#98D894",
          },
          MapPageNavigator: {
            label: "Map",
            barBackgroundColor: "#1E1E46",
            activeLabelColor: "#98D894",
          },
          GroupPageNavigator: {
            label: "Current Group",
            barBackgroundColor: "#1E1E46",
            activeLabelColor: "#98D894",
          },
          SettingsNavigator: {
            label: "Settings",
            barBackgroundColor: "#1E146",
            activeLabelColor: "#98D894",
          }
        }
      }
    }
  }
)

export default class App extends Component <{}> {
  render() {
    // return <RootStack />;
    return <TabBarPage />;
  }
}

// export TabBarPage

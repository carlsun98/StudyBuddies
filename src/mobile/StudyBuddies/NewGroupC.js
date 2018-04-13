/* Third page of create group flow. Needs to allow user to choose
 * how long the group will (initially) exist for before being
 * automatically disbanded.
 * TODO: -styling
 *       -proper setup of time choosing
 *******************************************************************/

'use strict';

import React, { Component } from 'react';

import {
    StackNavigator,
} from 'react-navigation';

import {
    StyleSheet,
    Text,
    TextInput,
    View,
    Button,
    ActivityIndicator,
    Image,
} from 'react-native';
import Moment from 'react-moment';
import moment from 'moment'
import NewGroupD from './NewGroupD'
import GroupPage from './GroupPage'
import styles from './stylings';

var nextTime = moment();

export default class NewGroupC extends Component<{}> {
    constructor(){
	super()
	this.state = {
    group_hours: '',
    group_minutes: '',
	}
    }
    _handlePress() {
      nextTime.add(parseInt(this.state.group_hours,10), 'hours');
      nextTime.add(parseInt(this.state.group_minutes,10), 'minutes')
      console.log("NEXT:" + nextTime.format())
	    this.props.navigation.navigate('NewGroupD')
    }

    render() {
	return (
              <View style={styles.container}>
		<Text style={styles.description}>
		  You Are Making a New Group!
                </Text>

	        <Text style={styles.description}>
		  Till about what time will you study?
                </Text>

                <View style={{flexDirection: 'row'}}>
                  <Text style={styles.description}>
                    Hours:
                  </Text>

                  <TextInput
                    style={styles.searchInput}
                    placeholder='     '
                    returnKeyType = {"next"}
                    onChangeText={(text) => this.setState({group_hours:text})}
                  />
                </View>

                <View style={{flexDirection: 'row'}}>
                  <Text style={styles.description}>
                    Minutes:
                  </Text>

                  <TextInput
                    style={styles.searchInput}
                    placeholder='     '
                    returnKeyType = {"next"}
                    onChangeText={(text) => this.setState({group_minutes:text})}
                  />
                </View>

		<View style={styles.buttons}>
		  <Button
                    onPress={() => this._handlePress()}
                    color = '#1E1E46'
	            title = "Next Step">
		  </Button>
		</View>
	      </View>
	);
    }
}

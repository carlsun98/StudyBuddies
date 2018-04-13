import { StyleSheet } from 'react-native';
// import { get, width, height, totalSize } from 'react-native-dimension';

export default StyleSheet.create({
    description: {
	marginBottom: 20,
        fontSize: 18,
        textAlign: 'center',
        color: '#1E1E46'
    },
    descriptionAsk: {
        marginBottom: 20,
        fontSize: 18,
	textAlign: 'left',
	color: '#656565'
    },
    container: {
	padding: 30,
	flex: 1,
	backgroundColor: '#98D894'
    },
    /*inputBoxes: {
      marginBottom: 20,
            textAlign: 'center',
            color: '#1E1E46'
    },*/
    buttons: {
	alignItems: 'center',
	paddingVertical: 5
    },
    searchInput: {
	height: 36,
	padding: 4,
	marginRight: 5,
	marginLeft: 5,
	fontSize: 18,
	borderWidth: 1,
	borderColor: '#1E1E46',
	borderRadius: 10,
	color: '#1E1E46',
    },
/*    positionInBottom: {
    position: 'absolute',
    width: 50,
    height: 50,
    bottom: 0,
    left: Dimensions.get('window').width - 70,
    backgroundColor: 'red',
    zIndex: 100,
},*/
});

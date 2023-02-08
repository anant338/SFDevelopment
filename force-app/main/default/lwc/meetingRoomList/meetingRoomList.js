import { LightningElement } from 'lwc';

export default class MeetingRoomList extends LightningElement {
    meetingRooms=[
        {'roomNo':'101' , 'capacity':10},
        {'roomNo':'Conf-111' , 'capacity':30},
        {'roomNo':'Auditorium' , 'capacity':200}


    ]
}
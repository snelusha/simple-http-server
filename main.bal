import ballerina/http;
import ballerina/time;

type Note record {
    readonly int id;
    string content;
    time:Date created_at;
};

service / on new http:Listener(8080) {
    private Note[] notes = [];

    resource function get notes() returns Note[] {
        return self.notes;
    }
}

import ballerina/http;

type Note record {
    readonly int id;
    string content;
};

service / on new http:Listener(8080) {
    private table<Note> key(id) notes = table [];

    resource function get notes() returns Note[] {
        return self.notes.toArray();
    }

    resource function get notes/[int id]() returns Note|http:NotFound {
        if (!self.notes.hasKey((id))) {
            return http:NOT_FOUND;
        }

        return self.notes.get(id);
    }

    
    resource function post notes(Note note) returns Note|http:Conflict {
        if (self.notes.hasKey(note.id)) {
            return http:CONFLICT;
        }

        self.notes.add(note);
        return note;
    }
}

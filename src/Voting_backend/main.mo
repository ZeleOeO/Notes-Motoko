import List "mo:base/List";
actor Note {
  var noteDatabase = List.nil<Note>();

  type Note = {
    title: Text;
    content: Text;
  };

  public query func getAllNotes(): async List.List<Note> {
    return noteDatabase;
  };

  public query func getNotesByTitle(title: Text): async List.List<Note> {
    let matchedNotes = List.filter<Note>(
      noteDatabase, 
      func note { 
        if(note.title == title){
          return true;
        }else{
          return false;
        }
      }
    );

    return matchedNotes;
  };

  public query func getNumberOfNotes(): async Nat {
    List.size<Note>(noteDatabase);
  };

  type NoteOperationResult = {
    #Success : Note;
    #Failure : Text;
  };

  public query func getNote(title: Text): async NoteOperationResult {
    let matchedNote = List.find<Note>(
      noteDatabase, 
      func note { 
        if(note.title == title){
          return true;
        }else{
          return false;
        }
      }
    );

    switch(matchedNote){
      case(null){
        return #Failure "could not find any notes";
      };

      case(?matchedNote){
        return #Success matchedNote;
      }
    }
  };

  public func batchAddNotes(newNoteList: List.List<Note>): async Text {
    let newList = List.append<Note>(noteDatabase, newNoteList);
    noteDatabase := newList;
    return "succesfully batch added notes";
  };

  public func addNewNote(note: Note): async Text {
    let newList = List.push<Note>(note, noteDatabase);
    noteDatabase := newList;
    return "succesfully added note" # " " # note.title;
  }
};

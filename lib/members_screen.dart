import 'package:flutter/material.dart';
import 'drawer.dart';
import 'add_member_screen.dart';
import 'edit_member_screen.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List<Member> members = [
    Member('Abdellatif', 'assets/member1.png', [
      Book('1984', 'George Orwell', 'assets/book1.jpg', 'A dystopian novel set in a totalitarian society under constant surveillance.'),
      Book('To Kill a Mockingbird', 'Harper Lee', 'assets/book2.jpg', 'A novel about the serious issues of rape and racial inequality.')
    ]),
    Member('Hassani', 'assets/member2.jpg', [
      Book('1984', 'George Orwell', 'assets/book1.jpg', 'A dystopian novel set in a totalitarian society under constant surveillance.')
    ]),
    Member('ENSET', 'assets/member2.jpg', [])
  ];

  List<Member> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
  }

  void _addMember(String name, String imageUrl) {
    setState(() {
      members.add(Member(name, imageUrl, []));
      filteredMembers = members;
    });
  }

  void _editMember(int index, String name, String imageUrl) {
    setState(() {
      members[index] = Member(name, imageUrl, members[index].borrowedBooks);
      filteredMembers = members;
    });
  }

  void _deleteMember(int index) {
    setState(() {
      members.removeAt(index);
      filteredMembers = members;
    });
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Voulez-vous vraiment supprimer cet adhérent ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteMember(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _filterMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembers = members;
      } else {
        filteredMembers = members.where((member) {
          return member.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adhérents'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un adhérent',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterMembers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(filteredMembers[index].image),
                    title: Text(filteredMembers[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemberDetailScreen(member: filteredMembers[index]),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMemberScreen(
                                  member: filteredMembers[index],
                                  index: index,
                                  editMember: _editMember,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmationDialog(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMemberScreen(addMember: _addMember),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Member {
  final String name;
  final String image;
  final List<Book> borrowedBooks;

  Member(this.name, this.image, this.borrowedBooks);
}

class Book {
  final String title;
  final String author;
  final String image;
  final String description;

  Book(this.title, this.author, this.image, this.description);
}

class MemberDetailScreen extends StatelessWidget {
  final Member member;

  MemberDetailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(member.image),
            SizedBox(height: 8.0),
            Text(
              member.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nombre de livres empruntés: ${member.borrowedBooks.length}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: member.borrowedBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(member.borrowedBooks[index].image),
                    title: Text(member.borrowedBooks[index].title),
                    subtitle: Text(member.borrowedBooks[index].author),
                    onTap: () {
                      // Navigate to book detail if needed
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

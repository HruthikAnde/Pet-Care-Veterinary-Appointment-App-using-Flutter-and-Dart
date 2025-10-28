import 'package:flutter/material.dart';
import '../models/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;

  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          backgroundImage: pet.imageUrl != null ? NetworkImage(pet.imageUrl!) : null,
          child: pet.imageUrl == null
              ? Icon(Icons.pets, color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        title: Text(
          pet.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${pet.type} • ${pet.breed} • ${pet.age} years'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
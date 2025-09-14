import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

class CharacterDetailPage extends StatefulWidget {
  final CharactersEntity character;

  const CharacterDetailPage({super.key, required this.character});

  static const routeName = '/character-detail';

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

   Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_characters') ?? [];
    setState(() {
      isFavorite = favoriteIds.contains(widget.character.id.toString());
    });
  }

  
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_characters') ?? [];

    setState(() {
      if (isFavorite) {
        favoriteIds.remove(widget.character.id.toString());
        isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removido dos favoritos!')),
        );
      } else {
        favoriteIds.add(widget.character.id.toString());
        isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adicionado aos favoritos!')),
        );
      }
    });

    await prefs.setStringList('favorite_characters', favoriteIds);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return const Color(0xFF00FF41);
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStatusColor(status),
          width: 2,
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.green.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: const Color(0xFF00FF41),
              size: 20,
            ),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            floating: false,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: const Color(0xFF00FF41),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'character-${character.name}',
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            character.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          _buildStatusBadge(character.status),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInfoItem(
                    'SPÉCIE',
                    character.species,
                    icon: Icons.person_outline,
                  ),
                  if (character.type.isNotEmpty)
                    _buildInfoItem(
                      'TYPE',
                      character.type,
                      icon: Icons.category_outlined,
                    ),
                  _buildInfoItem(
                    'GENDER',
                    character.gender,
                    icon: Icons.transgender,
                  ),
                  if (character.location.isNotEmpty)
                    _buildInfoItem(
                      'LOCATION',
                      character.location,
                      icon: Icons.location_on_outlined,
                    ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF00FF41).withOpacity(0.3),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '👽 WUBBA LUBBA DUB DUB! 👽',
                          style: TextStyle(
                            color: Color(0xFF00FF41),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This character is part of the infinite multiverse!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: _toggleFavorite,
        backgroundColor: const Color(0xFF00FF41),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }
}
